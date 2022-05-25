#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install apache2 php php-mysql -y
sudo apt-get install mysql-server -y

cd /tmp/
wget https://github.com/sdcilsy/sosial-media/archive/master.zip
Y
sudo apt-get install unzip
unzip master.zip

sudo rm /var/www/html/index.html
sudo mv sosial-media-master/* /var/www/html

cd /var/www/html/

DB_PASS='1234567890'

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';" 

sudo mysql -u root -p"${DB_PASS}" -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -u root -p"${DB_PASS}" -e "GRANT ALL PRIVILEGES on *.* to 'devopscilsy'@'localhost';"
sudo mysql -u devopscilsy -p"${DB_PASS}" -e "CREATE DATABASE dbsosmed;"
sudo mysql -u devopscilsy -p"${DB_PASS}" dbsosmed < dump.sql

