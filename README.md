# VPS Starter

This repository contains scripts to simplify the configuration and deployment of websites on a VPS server. It is particularly useful for system administrators and developers who want to automate the setting up of websites with Nginx and secure them with SSL certificates from Let's Encrypt.

# Table of Contents

- [Structure](#structure)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Preparing the Environment](#preparing-the-environment)
  - [Setting up a Website](#setting-up-a-website)
- [Specific Deployment Instructions](#specific-deployment-instructions)
  - [Nuxt.js 3 Deployment](#nuxtjs-3-deployment)
  - [Vue.js 3 Deployment](#vuejs-3-deployment)
  - [AdonisJS Deployment](#adonisjs-deployment)
- [Automated Database Backup](#automated-database-backup)
  - [Backup MariaDB Database to FTP](#backup-mariadb-database-to-ftp)
    - [Workflow Details](#workflow-details)
    - [Steps Performed](#steps-performed)
    - [Configuration](#configuration)
- [Resolve problems](#resolve-problems)
- [Contributions](#contributions)
- [License](#license)

## Structure

This repository is organized into separate folders for different web technologies:
- [prepare_environment.sh](prepare_environment.sh): Scripts and configurations for preparing the VPS to host websites.
- [setup_site.sh](setup_site.sh): Scripts and configurations for setting up websites with Nginx and Let's Encrypt.
- [nuxtjs3](nuxtjs3): Scripts and configurations for deploying Nuxt.js 3 applications.
- [vuejs3](vuejs3): Scripts and configurations for deploying Vue.js 3 applications.
- [adonisjs](adonisjs): Scripts and configurations for deploying AdonisJS applications.

Each folder contains a `deploy-vps.yml` file for GitHub Actions and an `nginx.conf` file for Nginx configuration specific to the technology.

## Features
- [prepare_environment.sh](prepare_environment.sh): A script to install Nginx and Certbot, thereby preparing the VPS to host websites.
- [setup_site.sh](setup_site.sh): A script to quickly configure a new website with Nginx and obtain an SSL certificate via Let's Encrypt.

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


## Specific Deployment Instructions

### Nuxt.js 3 Deployment

- #### GitHub Actions Workflow
1. Navigate to the [nuxtjs3](nuxtjs3) directory.
2. Use the [deploy-vps.yml](nuxtjs3/deploy-vps.yml) in your GitHub Actions workflow to automate the deployment process.
3. Add `SSH_HOST`, `SSH_USERNAME`, `SSH_PRIVATE_KEY`, and `SSH_PORT` as secrets to your GitHub repository.
4. Replace `/var/www/dibodev.com/html` with the path to your application on your VPS.
5. Replace `dibodev.com` with your pm2 process name.

- #### Nginx Configuration
1. Customize the [nginx.conf](nuxtjs3/nginx.conf) file as needed and place it in your Nginx configuration directory (usually `/etc/nginx/sites-available`) on your VPS.

### Notes on Nuxt.js 3 Deployment
- The GitHub Actions workflow for Nuxt.js 3 automates the process of pulling the latest code from the repository, installing dependencies, building the application, and deploying it to the specified VPS using SSH.
- The provided `nginx.conf` is optimized for Nuxt.js 3 applications and includes HTTPS configuration with HTTP/2 support.

## Vue.js 3 Deployment

- #### GitHub Actions Workflow
1. Navigate to the [vuejs3](vuejs3) directory.
2. Use the [deploy-vps.yml](vuejs3/deploy-vps.yml) in your GitHub Actions workflow to automate the deployment of Vue.js 3 applications.
3. Add `SSH_HOST`, `SSH_USERNAME`, `SSH_PRIVATE_KEY`, and `SSH_PORT` as secrets to your GitHub repository.
4. Replace `/var/www/dibodev.com/html` with the path to your application on your VPS.
5. After the deployment, verify the application is running correctly by accessing your domain in a web browser.

- #### Nginx Configuration
1. Customize the [nginx.conf](vuejs3/nginx.conf) file as per your requirements. This configuration sets up an HTTPS server for Vue.js 3 applications.
2. Place the `nginx.conf` file in the Nginx configuration directory (usually `/etc/nginx/sites-available`) on your VPS.
3. Ensure that the SSL certificates specified in the configuration are correctly installed and valid for your domain.
4. Test the Nginx configuration by running `sudo nginx -t` and then reload Nginx with `sudo systemctl reload nginx`.

### Notes on Vue.js 3 Deployment
- The GitHub Actions workflow for Vue.js 3 automates the process of pulling the latest code from the repository, installing dependencies, building the application, and deploying it to the specified VPS using SSH.
- The provided `nginx.conf` is optimized for Vue.js 3 applications and includes HTTPS configuration with HTTP/2 support.

### AdonisJS Deployment

- #### GitHub Actions Workflow
1. Navigate to the [adonisjs](adonisjs) directory.
2. Use the updated [deploy-vps.yml](adonisjs/deploy-vps.yml) in your GitHub Actions workflow to automate the deployment process of AdonisJS applications.
3. Add necessary secrets such as `SSH_HOST`, `SSH_USERNAME`, `SSH_PRIVATE_KEY`, `SSH_PORT`, `APP_KEY`, `DATABASE_DB_NAME`, `DATABASE_HOST`, `DATABASE_USERNAME`, and `DATABASE_PASSWORD` to your GitHub repository.
4. Modify the `APP_DIR` and `DOMAIN` environment variables in the workflow to match your deployment directory and pm2 process name.
5. The workflow now includes steps to set up the production `.env` file using `.env.production` and update it with secrets.

- #### Nginx Configuration
1. Ensure that the [nginx.conf](adonisjs/nginx.conf) file is customized for your AdonisJS application and placed in the Nginx configuration directory (usually `/etc/nginx/sites-available`) on your VPS.
2. After deployment, confirm that Nginx has restarted successfully and the application is running as expected.

### Notes on AdonisJS Deployment
- The updated deployment process simplifies the creation and updating of the `.env` file for production use.
- Additional commands have been added to restart the API using PM2, run database migrations, and seed the database after deployment.
- The deployment script now also ensures that Nginx is restarted, ensuring that any configuration changes are applied.

## Automated Database Backup
### Backup MariaDB Database to FTP

The [mariadb/backup-ftp-database.yml](mariadb/backup-ftp-database.yml) workflow automates the process of backing up your MariaDB database to an FTP server. 
This is crucial for ensuring data safety and quick recovery in case of data loss.

#### Workflow Details
  The workflow is scheduled to run every 12 hours (at 00:00 and 12:00 each day). It can also be triggered manually via GitHub Actions.

#### Steps Performed
1. Install MariaDB Client and Gzip: Prepares the environment by installing necessary tools.
2. MySQLDump - Database Backup: Connects to your MariaDB database and creates a compressed backup file.
3. Set Current Date and Time: Generates a timestamp to label the backup file.
4. Deploy Backup to FTP: Uploads the backup file to the specified FTP server.

#### Configuration
To use this workflow, you need to set the following secrets in your GitHub repository:
- `DATABASE_HOST`: The hostname of your MariaDB server.
- `DATABASE_USERNAME`: The username for the database.
- `DATABASE_PASSWORD`: The password for the database.
- `DATABASE_DB_NAME`: The name of the database to back up.
- `SERVER_FTP_HOST`: The FTP server hostname.
- `SERVER_FTP_USERNAME`: The FTP server username.
- `SERVER_FTP_PASSWORD`: The FTP server password.
- `SERVER_FTP_PORT`: The FTP server port (optional).

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
