#!/bin/bash
#set -e

#echo "🚀 Starting deployment..."

# Make sure nginx is installed
#sudo apt-get update -y
#sudo apt-get install -y nginx

#echo "🧹 Cleaning old files..."
#sudo rm -rf /var/www/html/*

#echo "📂 Deploying new files..."
#sudo cp -r ~/app/* /var/www/html/
#echo "install npm packages"
#npm install
#echo "start npm server"
#HOST=0.0.0.0 npm start

#echo "✅ Deployment complete. Access your app via the VM's external IP."


set -e

echo "🚀 Starting deployment..."

cd ~/app || exit 1

# Install dependencies only if package.json exists
if [ -f "package.json" ]; then
  echo "📦 Installing npm dependencies..."
  npm install --production
else
  echo "⚠️ No package.json found, skipping npm install"
fi

# Restart app
echo "🔄 Restarting app with PM2..."
pm2 delete all || true
pm2 start server.js --name my-app

