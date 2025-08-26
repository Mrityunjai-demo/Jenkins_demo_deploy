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
set -e

echo "🚀 Starting deployment..."

# Navigate to app directory
cd ~/app

# Clean old node_modules if exists
if [ -d "node_modules" ]; then
  echo "🧹 Removing old node_modules..."
  rm -rf node_modules
fi

# Install dependencies
echo "📦 Installing npm dependencies..."
npm install --production

# Build the app (if applicable, e.g. React/Next.js)
if [ -f "package.json" ] && grep -q "\"build\"" package.json; then
  echo "🔨 Building the app..."
  npm run build
fi

# Restart the app (using pm2 or node)
if command -v pm2 >/dev/null 2>&1; then
  echo "🔄 Restarting app with pm2..."
  pm2 restart app || pm2 start server.js --name app
else
  echo "⚡ Starting app with node..."
  nohup node server.js > app.log 2>&1 &
fi

echo "✅ Deployment finished successfully!"

