#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install apache2 php php-mysql -y
sudo apt-get install mysql-server -y

cd /tmp/
wget https://github.com/irwankilay/smallproject1/archive/refs/heads/master.zip

sudo apt-get install unzip
unzip master.zip

DB_PASS='1234567890'
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';" 
sudo mysql -u root -p"${DB_PASS}" -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -u root -p"${DB_PASS}" -e "GRANT ALL PRIVILEGES on *.* to 'devopscilsy'@'localhost';"
sudo mysql -u devopscilsy -p"${DB_PASS}" -e "CREATE DATABASE wordpress;"

cd /var/www/html/
wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz

sudo mv -f /tmp/smallproject1-master/wp-config.php /var/www/html/wordpress
sudo mv -f /tmp/smallproject1-master/000-default.conf /etc/apache2/sites-available
sudo mv -f /tmp/smallproject1-master/resolv.conf /etc
sudo rm /var/www/html/index.html
sudo service apache2 restart

