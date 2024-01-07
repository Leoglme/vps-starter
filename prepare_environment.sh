#!/bin/bash

# Updating package lists
echo "Updating package lists..."
sudo apt update

# Installing Nginx
echo "Installing Nginx..."
sudo apt install -y nginx

# Installing Certbot and its Nginx extension
echo "Installing Certbot and its Nginx extension..."
sudo apt install -y certbot python3-certbot-nginx

# Enabling Nginx (if necessary)
echo "Enabling Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

# Installing dig (if necessary)
echo "Installing dig..."
sudo apt install -y dnsutils

# Installing node.js (if necessary)
echo "Installing node.js..."
sudo apt install -y nodejs

# Installing npm (if necessary)
echo "Installing npm..."
sudo apt install -y npm

echo "Environment has been successfully prepared."