# VPS Starter

This repository contains scripts to simplify the configuration and deployment of websites on a VPS server. It is particularly useful for system administrators and developers who want to automate the setting up of websites with Nginx and secure them with SSL certificates from Let's Encrypt.

## Features

- `prepare_environment.sh`: A script to install Nginx and Certbot, thereby preparing the VPS to host websites.
- `setup_site.sh`: A script to quickly configure a new website with Nginx and obtain an SSL certificate via Let's Encrypt.

## Prerequisites

- A Linux VPS (preferably Debian or Ubuntu)
- A domain name (e.g. `example.com`) with an A record pointing to the IP address of the VPS
- A user account with `sudo` privileges

## Usage

### Preparing the Environment
1. Clone this repository to your VPS or directly download the scripts.
2. Make the `prepare_environment.sh` script executable by running `chmod +x prepare_environment.sh`
3. Run the script with `sudo sh ./prepare_environment.sh`

### Setting up a Website
1. Clone this repository to your VPS or directly download the scripts.
2. Make the `setup_site.sh` script executable by running `chmod +x setup_site.sh`
3. Run the script with `sudo sh ./setup_site.sh example.com`
<br>
Replace `example.com` with your domain or subdomain name.


## Contributions
Contributions to this project are welcome. Feel free to propose improvements or report issues via GitHub issues.

## License
MIT License by [Leoglme](https://github.com/Leoglme)