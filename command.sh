#!/bin/sh

ufw allow 'Nginx HTTP'
ufw allow 'Nginx HTTPS'
ufw allow 'OpenSSH'
ufw enable
ufw status

apt install mysql-server -y
mysql --execute="CREATE USER 'kelompok5'@'localhost' IDENTIFIED BY 'kelompok5';"
mysql --execute="CREATE DATABASE laravel;"
apt install php-fpm php-mysql -y

mkdir /var/www/kanza.akunlain.my.id
chown -R $USER:$USER /var/www/kanza.akunlain.my.id

echo """server {
    listen 80;
    listen [::]:80;
    server_name kanza.akunlain.my.id www.kanza.akunlain.my.id;
    root /var/www/kanza.akunlain.my.id/public;

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }

}
""" >>  /etc/nginx/sites-available/kanza.akunlain.my.id

ln -s /etc/nginx/sites-available/kanza.akunlain.my.id /etc/nginx/sites-enabled/
unlink /etc.nginx/sites-enabled/default
nginx -t
systemctl reload nginx
git clone https://gitlab.com/kuuhaku86/web-penugasan-individu.git /var/www/kanza.akunlain.my.id/
apt install composer -y
composer update
cp /var/www/kanza.akunlain.my.id/.env.example  /var/www/kanza.akunlain.my.id/.env

echo '''
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=kelompok5
DB_PASSWORD=kelompok5

BROADCAST_DRIVER=log
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=null
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
''' > /var/www/kanza.akunlain.my.id/.env


php artisan key:generate
php artisan migrate
cd /var/www/kanza.akunlain.my.id/
chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
apt install certbot
sudo certbot certonly --webroot --webroot-path=/var/www/kanza.akunlain.my.id/public -d kanza.akunlain.my.id -d www.kanza.akunlain.my.id
