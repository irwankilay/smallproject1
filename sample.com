# Redirect HTTP -> HTTPS
server {
listen 80;
server_name wpress.masehada.com;

include snippets/letsencrypt.conf;
return 301 https://wpress.masehada.com$request_uri;
}

# Redirect WWW -> NON-WWW
server {
listen 443 ssl http2;
server_name wpress.masehada.com;

ssl_certificate /etc/letsencrypt/live/wpress.masehada.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/wpress.masehada.com/privkey.pem;
ssl_trusted_certificate /etc/letsencrypt/live/wpress.masehada.com/chain.pem;
include snippets/ssl.conf;

return 301 https://wpress.masehada.com$request_uri;
}

server {
listen 443 ssl http2;
server_name wpress.masehada.com;

root /var/www/html/wpress.masehada.com;
index index.php;

# SSL parameters
ssl_certificate /etc/letsencrypt/live/wpress.masehada.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/wpress.masehada.com/privkey.pem;
ssl_trusted_certificate /etc/letsencrypt/live/wpress.masehada.com/chain.pem;
include snippets/ssl.conf;
include snippets/letsencrypt.conf;

# log files
access_log /var/log/nginx/wpress.masehada.com.access.log;
error_log /var/log/nginx/wpress.masehada.com.error.log;

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
