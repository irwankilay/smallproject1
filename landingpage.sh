#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y

cd /tmp/
wget https://github.com/irwankilay/landing-page/archive/refs/heads/master.zip

sudo apt-get install unzip
unzip master.zip

sudo rm /var/www/html/index.html
sudo mv landing-page-master/* /var/www/html

cd /var/www/html/