#!/bin/bash
cd /var/www/html/EDUC-DOG
sudo chown -R ubuntu:www-data /var/www/html/EDUC-DOG

/usr/local/bin/aws s3 cp s3://daska-prod-env/daska-prod-env .env >> /home/ubuntu/logs/aws-s3-copy.log
/usr/local/bin/composer update >> /home/ubuntu/logs/composer.log
sudo chmod -R 777 app/ bootstrap/ storage/ >> /home/ubuntu/logs/permission.log
/usr/bin/php8.2 artisan o:c >> /home/ubuntu/logs/cache-clean.log
sudo service apache2 reload >> /home/ubuntu/logs/apache2.log

#for socket
npm i
pm2 reload edu-dog-socket >> /home/ubuntu/logs/pm2_reload.logss