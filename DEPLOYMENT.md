# Deployment Guide

## 🚀 Deploying Your AI Cover Letter Generator

### Environment Variables Setup

1. **Create a `.env` file** (for local development):
```bash
cp .env.example .env
```

2. **Fill in your actual values**:
```env
N8N_WEBHOOK_URL=https://chaseai.app.n8n.cloud/webhook/287ffdec-8d2c-42eb-8532-ac60971f8226
SECRET_KEY_BASE=your-generated-secret-key
```

3. **Generate a secret key**:
```bash
rails secret
```

### 📦 GitHub Setup

1. **Initialize Git** (if not already done):
```bash
git init
git add .
git commit -m "Initial commit: AI Cover Letter Generator"
```

2. **Create GitHub repository**:
- Go to GitHub.com
- Create new repository
- Follow the instructions to push your code

3. **Push to GitHub**:
```bash
git remote add origin https://github.com/yourusername/ai-cover-letter-generator.git
git branch -M main
git push -u origin main
```

### 🌐 Deployment Options

#### Option 1: Railway (Recommended for Rails)
Railway is excellent for Rails apps and handles databases automatically.

1. **Visit [railway.app](https://railway.app)**
2. **Connect your GitHub repository**
3. **Set environment variables**:
   - `N8N_WEBHOOK_URL`: Your n8n webhook URL
   - `RAILS_MASTER_KEY`: Generate with `rails credentials:edit`
4. **Deploy automatically**

#### Option 2: Render (Great Rails Support)
1. **Visit [render.com](https://render.com)**
2. **Create new Web Service**
3. **Connect GitHub repository**
4. **Configure**:
   - Build Command: `bundle install && rails assets:precompile && rails db:migrate`
   - Start Command: `rails server -p $PORT -e production`
5. **Set environment variables**

#### Option 3: Heroku (Classic Choice)
1. **Install Heroku CLI**
2. **Create app**:
```bash
heroku create your-app-name
```
3. **Set environment variables**:
```bash
heroku config:set N8N_WEBHOOK_URL=your-webhook-url
heroku config:set RAILS_MASTER_KEY=your-master-key
```
4. **Deploy**:
```bash
git push heroku main
```

#### Option 4: DigitalOcean App Platform
1. **Visit [digitalocean.com/products/app-platform](https://digitalocean.com/products/app-platform)**
2. **Connect GitHub repository**
3. **Configure build settings**
4. **Set environment variables**

### 🔧 Production Configuration

#### Update for Production Database
For production, you might want to use PostgreSQL instead of SQLite:

1. **Add to Gemfile**:
```ruby
group :production do
  gem 'pg', '~> 1.1'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'
end
```

2. **Update database.yml**:
```yaml
production:
  <<: *default
  adapter: postgresql
  url: <%= ENV['DATABASE_URL'] %>
```

#### Environment Variables for Production
Set these on your deployment platform:

- `N8N_WEBHOOK_URL`: Your n8n webhook URL
- `SECRET_KEY_BASE`: Generate with `rails secret`
- `RAILS_ENV`: `production`
- `RAILS_SERVE_STATIC_FILES`: `true`
- `RAILS_LOG_TO_STDOUT`: `true`

### 🌍 Custom Domain Setup

Once deployed, you can:
1. **Get your deployment URL** (e.g., `https://your-app.railway.app`)
2. **Set up custom domain** through your platform
3. **Update n8n webhook** if needed

### 🔒 Security Considerations

1. **Never commit `.env` files**
2. **Use environment variables for all secrets**
3. **Enable HTTPS** (most platforms do this automatically)
4. **Consider rate limiting** for production use

### 📱 Mobile Responsiveness

Your app is already mobile-responsive with the beautiful UI we built!

### 🎯 Why Not Vercel?

Vercel is primarily designed for:
- Static sites
- Next.js applications
- Serverless functions

Rails applications need:
- Persistent server processes
- Database connections
- File system access

**Better alternatives for Rails:**
- **Railway** ⭐ (Best for Rails)
- **Render** ⭐ (Excellent Rails support)
- **Heroku** (Classic choice)
- **DigitalOcean App Platform**

### 🚀 Quick Deploy Commands

```bash
# 1. Install dependencies
bundle install

# 2. Add dotenv gem
bundle add dotenv-rails

# 3. Create environment file
cp .env.example .env

# 4. Generate secret
rails secret

# 5. Setup Git
git init
git add .
git commit -m "Ready for deployment"

# 6. Push to GitHub
# (Create repo on GitHub first)
git remote add origin https://github.com/yourusername/repo-name.git
git push -u origin main

# 7. Deploy to Railway/Render/Heroku
# Follow platform-specific instructions above
```

Your app will be accessible worldwide once deployed! 🌍 