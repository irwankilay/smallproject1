#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install apache2 php php-mysql -y
sudo apt-get install mysql-server -y

cd /tmp/
wget https://github.com/sdcilsy/sosial-media/archive/master.zip
sudo mv master.zip master1.zip

wget https://github.com/irwankilay/smallproject1/archive/refs/heads/master.zip
sudo mv master.zip master2.zip

sudo apt-get install unzip
unzip master1.zip
unzip master2.zip

sudo rm /var/www/html/index.html
sudo mv sosial-media-master/* /var/www/html
sudo mv -f smallproject1-master/resolv.conf /etc

cd /var/www/html/

DB_PASS='1234567890'

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';" 

sudo mysql -u root -p"${DB_PASS}" -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -u root -p"${DB_PASS}" -e "GRANT ALL PRIVILEGES on *.* to 'devopscilsy'@'localhost';"
sudo mysql -u devopscilsy -p"${DB_PASS}" -e "CREATE DATABASE dbsosmed;"
sudo mysql -u devopscilsy -p"${DB_PASS}" dbsosmed < dump.sql

