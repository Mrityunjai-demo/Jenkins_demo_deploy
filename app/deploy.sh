#!/bin/bash

# Example: deploy a simple web app
echo "Starting deployment on VM..."

# Update and install dependencies if needed
sudo apt-get update
sudo apt-get install -y nginx

# Copy your app files (assuming you copied them to ~/app)
# Example: move HTML files to Nginx web root
sudo cp ~/app/*.html /var/www/html/

# Restart web server
sudo systemctl restart nginx

echo "Deployment completed successfully!"
