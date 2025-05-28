#!/bin/bash

echo "🚀 AI Cover Letter Generator - Setup Script"
echo "==========================================="

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Please run this script from the Rails application directory"
    exit 1
fi

echo "📦 Installing dependencies..."
bundle install

echo "🗄️ Setting up database..."
rails db:create
rails db:migrate

echo "🔧 Setting up environment variables..."
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "✅ Created .env file from template"
    echo "⚠️  Please edit .env with your actual n8n webhook URL"
else
    echo "✅ .env file already exists"
fi

echo "🔑 Generating secret key..."
SECRET_KEY=$(rails secret)
echo "Your secret key: $SECRET_KEY"
echo "💡 Save this for your production deployment!"

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env with your n8n webhook URL"
echo "2. Run: rails server"
echo "3. Visit: http://localhost:3000"
echo ""
echo "For deployment:"
echo "1. Push to GitHub"
echo "2. Deploy to Railway/Render/Heroku"
echo "3. Set environment variables on your platform"
echo ""
echo "See DEPLOYMENT.md for detailed instructions"

chmod +x setup.sh 