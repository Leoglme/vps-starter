# VPS Starter

This repository contains scripts to simplify the configuration and deployment of websites on a VPS server. It is particularly useful for system administrators and developers who want to automate the setting up of websites with Nginx and secure them with SSL certificates from Let's Encrypt.

## Structure

This repository is organized into separate folders for different web technologies:
- `preparte_environment`: Scripts and configurations for preparing the VPS to host websites.
- `setup_site`: Scripts and configurations for setting up websites with Nginx and Let's Encrypt.
- `nuxtjs3`: Scripts and configurations for deploying Nuxt.js 3 applications.
- `vuejs3`: Scripts and configurations for deploying Vue.js 3 applications.
- `adonisjs`: Scripts and configurations for deploying AdonisJS applications.

Each folder contains a `deploy-vps.yml` file for GitHub Actions and an `nginx.conf` file for Nginx configuration specific to the technology.

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


## Nuxt.js 3 / Vue.js 3 / AdonisJS Deployment
### How to Use

1. Navigate to the folder for your technology (e.g. `nuxtjs3`).
2. Use the `deploy-vps.yml` in your GitHub Actions workflow to automate the deployment process.
3. Add `SSH_HOST`, `SSH_USERNAME`, `SSH_PRIVATE_KEY`, and `SSH_PORT` as secrets to your GitHub repository.
4. Replace `/var/www/dibodev.com/html` with the path to your application on your VPS.
5. Replace `dibodev.com` with your pm2 process name.
6. Customize the `nginx.conf` file as needed and place it in your Nginx configuration directory (usually `/etc/nginx/sites-available`) on your VPS.

## Resolve problems
- resolve the right problem on job 📤 Deploy to VPS
  - check whether the user `SSH_USERNAME` has the necessary rights to the path `/var/www/[domain]/html`: 
  ```shell
    ls -ld /var/www/[domain]/html
  ```
    - if not, change the owner of the path `/var/www/[domain]/html` to the user `SSH_USERNAME`:
    ```shell
        sudo chown -R [SSH_USERNAME]:[SSH_USERNAME] /var/www/[domain]/html
    ```

## Contributions
Contributions to this project are welcome. Feel free to propose improvements or report issues via GitHub issues.

## License
MIT License by [Leoglme](https://github.com/Leoglme)