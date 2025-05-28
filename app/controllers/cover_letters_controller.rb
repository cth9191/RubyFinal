require 'net/http'
require 'uri'
require 'json'

class CoverLettersController < ApplicationController
  def new
    @cover_letter = CoverLetter.new
  end

  def create
    @cover_letter = CoverLetter.new(cover_letter_params)
    
    if @cover_letter.save
      webhook_response = send_to_n8n(@cover_letter)
      
      if webhook_response[:success]
        @cover_letter.update(generated_letter: webhook_response[:data])
        redirect_to cover_letter_path(@cover_letter), notice: 'Cover letter generated successfully!'
      else
        sample_letter = generate_sample_letter(@cover_letter)
        @cover_letter.update(generated_letter: sample_letter)
        flash[:notice] = "Demo mode: Using sample cover letter. Configure n8n webhook for AI generation."
        redirect_to cover_letter_path(@cover_letter)
      end
    else
      render :new
    end
  end

  def show
    @cover_letter = CoverLetter.find(params[:id])
  end

  private

  def cover_letter_params
    params.require(:cover_letter).permit(:user_name, :company_name, :role, :extra_info)
  end

  def send_to_n8n(cover_letter)
    require_relative '../../config/webhook_config'
    webhook_url = WebhookConfig::N8N_WEBHOOK_URL
    
    if webhook_url.include?('your-n8n-instance.com')
      return { success: false, error: "Webhook URL not configured" }
    end
    
    begin
      uri = URI(webhook_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http.read_timeout = 30
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      
      payload = {
        user_name: cover_letter.user_name,
        company_name: cover_letter.company_name,
        role: cover_letter.role,
        extra_info: cover_letter.extra_info
      }
      
      request.body = payload.to_json
      response = http.request(request)
      
      if response.code == '200'
        response_data = JSON.parse(response.body)
        cover_letter_content = extract_cover_letter_content(response_data)
        { success: true, data: cover_letter_content }
      else
        { success: false, error: "HTTP #{response.code}: #{response.message}" }
      end
      
    rescue => e
      { success: false, error: e.message }
    end
  end

  def extract_cover_letter_content(response_data)
    content = nil
    
    if response_data.is_a?(Hash)
      content = response_data['output'] || 
                response_data['generated_letter'] || 
                response_data['letter'] || 
                response_data['content'] ||
                response_data['text']
    end
    
    content ||= response_data.to_s
    
    if content.is_a?(String)
      content = content.gsub('\\n', "\n")
      content = content.strip.gsub(/^"/, '').gsub(/"$/, '')
      content = content.gsub('\\"', '"')
    end
    
    content
  end

  def generate_sample_letter(cover_letter)
    <<~LETTER
      Dear Hiring Manager,

      I am writing to express my strong interest in the #{cover_letter.role} position at #{cover_letter.company_name}. With my background and passion for this field, I am confident that I would be a valuable addition to your team.

      #{cover_letter.extra_info.present? ? "I bring #{cover_letter.extra_info.downcase} to this role, which I believe aligns well with your requirements." : "I am excited about the opportunity to contribute to your organization's success."}

      I am particularly drawn to #{cover_letter.company_name} because of its reputation for innovation and excellence. I would welcome the opportunity to discuss how my skills and enthusiasm can contribute to your team's continued success.

      Thank you for considering my application. I look forward to hearing from you soon.

      Sincerely,
      #{cover_letter.user_name}

      ---
      Note: This is a sample cover letter generated for demonstration purposes. 
      Configure your n8n webhook URL in config/webhook_config.rb for AI-powered generation.
    LETTER
  end
end
