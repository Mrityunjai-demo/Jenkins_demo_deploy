#!/bin/bash
set -e

echo "🚀 Starting deployment..."

# Make sure nginx is installed
sudo apt-get update -y
sudo apt-get install -y nginx

echo "🧹 Cleaning old files..."
sudo rm -rf /var/www/html/*

echo "📂 Deploying new files..."
sudo cp -r ~/app/* /var/www/html/

echo "✅ Deployment complete. Access your app via the VM's external IP."
