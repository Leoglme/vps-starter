#!/bin/bash

# Check if a domain is provided
if [ -z "$1" ]
then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1

# Creating directory for the site
sudo mkdir -p /var/www/$DOMAIN/html

# Setting permissions
sudo chown -R "$USER":"$USER" /var/www/"$DOMAIN"/html

# Creating a test index page
echo "Welcome to $DOMAIN" | sudo tee /var/www/"$DOMAIN"/html/index.html

# Configuring Nginx
CONFIG_FILE="/etc/nginx/sites-available/$DOMAIN"
sudo touch "$CONFIG_FILE"
echo "server {
    listen 80;
    listen [::]:80;

    root /var/www/$DOMAIN/html;
    index index.html index.htm index.nginx-debian.html;

    server_name $DOMAIN www.$DOMAIN;

    location / {
        try_files \$uri \$uri/ =404;
    }
}" | sudo tee "$CONFIG_FILE"

# Enabling the site
sudo ln -s /etc/nginx/sites-available/"$DOMAIN" /etc/nginx/sites-enabled/

# Testing Nginx configuration
sudo nginx -t

# Restarting Nginx
sudo systemctl restart nginx

# Configuring SSL with Certbot
sudo certbot --nginx -d "$DOMAIN" -d www."$DOMAIN" --non-interactive --agree-tos -m your-email@example.com --redirect

# Restarting Nginx
sudo systemctl restart nginx

echo "Site $DOMAIN successfully configured."
