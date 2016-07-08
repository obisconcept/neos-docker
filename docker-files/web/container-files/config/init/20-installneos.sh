#!/bin/bash

wait_for_db

create_app_db

git clone $NEOS_REPO /var/www/neos-app/

cp -a /var/www/neos-app/. /var/www/neos
rm -R /var/www/neos-app/

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

cd /var/www/neos
composer install

cp -R /config/neos/Settings.yaml Configuration/Settings.yaml

executed_migrations=$(get_db_executed_migrations)

if [[ $executed_migrations == 0 ]]; then
    log "Migrate database..."
    ./flow doctrine:migrate

    log "Import site package..."
    ./flow neos:site:import --package-key=$NEOS_SITE

    log "Creating admin user..."
    ./flow user:create --roles Administrator $NEOS_USERNAME $NEOS_PASSWORD $NEOS_FNAME $NEOS_LNAME

    log "Configure vHost..."
    cp -R /config/neos/neos.conf /etc/apache2/sites-available/neos.conf
    a2ensite neos.conf
    a2enmod rewrite
    apache2ctl restart
else
    log "Neos app is already set up..."
fi

./flow flow:cache:flush --force