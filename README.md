# AI Cover Letter Generator 🚀

A beautiful, modern Rails application that generates personalized cover letters using AI through n8n automation workflows.

![Cover Letter Generator](https://img.shields.io/badge/Rails-7.1.5-red) ![Ruby](https://img.shields.io/badge/Ruby-3.0+-red) ![Status](https://img.shields.io/badge/Status-Production%20Ready-green)

## ✨ Features

- **🎨 Beautiful Modern UI** - Glass-morphism design with smooth animations
- **🤖 AI-Powered Generation** - Integrates with n8n workflows for intelligent cover letter creation
- **📱 Mobile Responsive** - Works perfectly on all devices
- **⚡ Fast & Secure** - Built with Rails best practices
- **🔧 Easy Deployment** - Ready for production deployment

## 🚀 Quick Start

### Local Development

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/ai-cover-letter-generator.git
cd ai-cover-letter-generator
```

2. **Install dependencies**
```bash
bundle install
```

3. **Set up the database**
```bash
rails db:create
rails db:migrate
```

4. **Configure your n8n webhook**
```bash
cp .env.example .env
# Edit .env with your actual n8n webhook URL
```

5. **Start the server**
```bash
rails server
```

Visit `http://localhost:3000` to see your application!

### Environment Variables

Set these environment variables on your deployment platform:

- `N8N_WEBHOOK_URL` - Your n8n webhook endpoint
- `SECRET_KEY_BASE` - Generate with `rails secret`
- `RAILS_ENV` - Set to `production`

See `DEPLOYMENT.md` for detailed deployment instructions.

## 🔧 Configuration

### n8n Webhook Setup

1. Create an n8n workflow that accepts webhook data
2. Configure your workflow to process:
   - `user_name` - Applicant's name
   - `company_name` - Target company
   - `role` - Position applying for
   - `extra_info` - Additional details
3. Return the generated cover letter in the response

### Webhook Response Format

Your n8n workflow should return JSON in this format:
```json
{
  "output": "Dear Hiring Manager,\n\nYour generated cover letter content here..."
}
```

## 📁 Project Structure

```
cover_letter_generator/
├── app/
│   ├── controllers/cover_letters_controller.rb
│   ├── models/cover_letter.rb
│   └── views/cover_letters/
│       ├── new.html.erb      # Beautiful form interface
│       └── show.html.erb     # Stunning results display
├── config/
│   └── webhook_config.rb     # n8n webhook configuration
├── DEPLOYMENT.md             # Comprehensive deployment guide
└── README.md                 # This file
```

## 🚀 Getting Started with Deployment

1. **Push to GitHub**:
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/repo-name.git
git push -u origin main
```

2. **Deploy to Railway** (recommended):
   - Visit [railway.app](https://railway.app)
   - Connect your GitHub repository
   - Set your `N8N_WEBHOOK_URL` environment variable
   - Deploy automatically!

3. **Your app will be live** at `https://your-app.railway.app`



