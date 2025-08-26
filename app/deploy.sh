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

#!/bin/bash
APP_DIR=~/app
SERVER_FILE="$APP_DIR/server.js"

echo "🚀 Starting deployment script..."

# Navigate to app directory
if [ -d "$APP_DIR" ]; then
    cd "$APP_DIR" || { echo "❌ Cannot enter $APP_DIR"; exit 1; }
else
    echo "❌ App directory $APP_DIR does not exist. Exiting."
    exit 1
fi

# Install npm dependencies
if [ -f package.json ]; then
    echo "📦 Installing npm dependencies..."
    npm install || echo "⚠️ npm install encountered issues. Continuing..."
else
    echo "⚠️ package.json not found. Skipping npm install."
fi

# Check for server.js before starting with PM2
if [ -f "$SERVER_FILE" ]; then
    echo "🔄 Restarting app with PM2..."
    pm2 stop server.js 2>/dev/null || true
    pm2 start server.js || echo "⚠️ PM2 failed to start server.js"
else
    echo "⚠️ server.js not found. Skipping PM2 start."
fi

echo "✅ Deployment script finished."
