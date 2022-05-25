# Redirect HTTP -> HTTPS
server {
listen 80;
server_name www.sample.com sample.com;

include snippets/letsencrypt.conf;
return 301 https://sample.com$request_uri;
}

# Redirect WWW -> NON-WWW
server {
listen 443 ssl http2;
server_name www.sample.com;

ssl_certificate /etc/letsencrypt/live/sample.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/sample.com/privkey.pem;
ssl_trusted_certificate /etc/letsencrypt/live/sample.com/chain.pem;
include snippets/ssl.conf;

return 301 https://sample.com$request_uri;
}

server {
listen 443 ssl http2;
server_name sample.com;

root /var/www/html/sample.com;
index index.php;

# SSL parameters
ssl_certificate /etc/letsencrypt/live/sample.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/sample.com/privkey.pem;
ssl_trusted_certificate /etc/letsencrypt/live/sample.com/chain.pem;
include snippets/ssl.conf;
include snippets/letsencrypt.conf;

# log files
access_log /var/log/nginx/sample.com.access.log;
error_log /var/log/nginx/sample.com.error.log;

location = /favicon.ico {
log_not_found off;
access_log off;
}

location = /robots.txt {
allow all;
log_not_found off;
access_log off;
}

location / {
try_files $uri $uri/ /index.php?$args;
}

location ~ \.php$ {
include snippets/fastcgi-php.conf;
fastcgi_pass unix:/run/php/php7.2-fpm.sock;
}

location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
expires max;
log_not_found off;
}
}
