#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install bind9 -y

cd /tmp/
wget https://github.com/irwankilay/landing-page/archive/refs/heads/master.zip
mv master.zip landingpage.zip

wget https://github.com/irwankilay/smallproject1/archive/refs/heads/master.zip
mv master.zip smallproject1.zip

sudo apt-get install unzip
unzip landingpage.zip
unzip smallproject1.zip

sudo rm /var/www/html/index.html
sudo mv landing-page-master/* /var/www/html
sudo mv -f smallproject1-master/named.conf.options /etc/bind
sudo mv -f smallproject1-master/named.conf.local /etc/bind
sudo mv smallproject1-master/db.samehada /etc/bind
sudo mv smallproject1-master/db.56 /etc/bind
sudo mv -f smallproject1-master/resolv.conf /etc

cd /var/www/html/

sudo service bind9 start
