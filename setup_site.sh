#!/bin/bash

# Check domain propagation
check_dns() {
    local domain=$1
    echo "Checking DNS propagation for $domain..."

    # Obtaining the domain's real IP address
    local dns_ip
    if ! dns_ip=$(dig +short "$domain" @8.8.8.8); then
        echo "Error retrieving DNS IP address for $domain."
        return 1
    fi

    # Obtain the server IP address (assumed to be the public IP address of the VPS)
    local server_ip
    if ! server_ip=$(curl -s http://ipecho.net/plain); then
        echo "Error retrieving server IP address."
        return 1
    fi

    if [ "$dns_ip" = "$server_ip" ]; then
        echo "DNS propagation for $domain is correct (IP: $dns_ip)."
        return 0
    else
        echo "DNS propagation for $domain is not yet complete (DNS IP: $dns_ip, Server IP: $server_ip)."
        return 1
    fi
}


# Check if a domain is provided
if [ -z "$1" ]
then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1

# Checking DNS records
if ! check_dns "$DOMAIN" || ! check_dns "www.$DOMAIN"; then
    echo "The DNS records have not yet been propagated. Please try again later."
    exit 1
fi

# Creating directory for the site
sudo mkdir -p /var/www/"$DOMAIN"/html

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
