#!/bin/bash
cd <project_path>
sudo chown -R ubuntu:www-data <project_path>

/usr/local/bin/aws s3 cp s3://daska-prod-env/daska-prod-env .env >> /home/ubuntu/logs/aws-s3-copy.log
/usr/local/bin/composer install >> /home/ubuntu/logs/composer.log
sudo chmod -R 777 app/ bootstrap/ storage/ >> /home/ubuntu/logs/permission.log
/usr/bin/php8.2 artisan migrate --force >> /home/ubuntu/logs/migrate.log
/usr/bin/php8.2 artisan db:seed --class=SectionsTableSeeder --force >> /home/ubuntu/logs/sections-seeder.log
/usr/bin/php8.2 artisan db:seed --class=RolesTableSeeder --force >> /home/ubuntu/logs/roles-seeder.log

/usr/bin/php8.2 artisan o:c >> /home/ubuntu/logs/cache-clean.log

sudo service apache2 reload >> /home/ubuntu/logs/apache2.log

#for socket
/usr/bin/npm install --force >> /home/ubuntu/logs/npm-install.log
pm2 reload edu-dog-socket >> /home/ubuntu/logs/pm2_reload.logss