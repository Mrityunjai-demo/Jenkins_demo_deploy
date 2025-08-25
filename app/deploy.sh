#!/bin/bash
set -e

echo "🚀 Starting deployment..."

# Ensure target directory exists
sudo mkdir -p /var/www/html

# Clean old files
echo "🧹 Cleaning old files..."
sudo rm -rf /var/www/html/*

# Detect what to deploy
if [ -f ~/app/index.html ]; then
    echo "📄 Found static HTML files, deploying..."
    sudo cp -r ~/app/* /var/www/html/

elif [ -d ~/app/build ]; then
    echo "⚛️ Found React build folder, deploying..."
    sudo cp -r ~/app/build/* /var/www/html/

elif [ -d ~/app/dist ]; then
    echo "🅰️ Found Angular/Vue dist folder, deploying..."
    sudo cp -r ~/app/dist/* /var/www/html/

else
    echo "❌ No deployable files found (index.html / build/ / dist/ missing)"
    exit 1
fi

# Restart nginx (or install if missing)
if ! command -v nginx &> /dev/null; then
    echo "🌐 Installing nginx..."
    sudo apt-get update
    sudo apt-get install -y nginx
fi

echo "🔄 Restarting nginx..."
sudo systemctl restart nginx

echo "✅ Deployment complete! Your app should be live."
