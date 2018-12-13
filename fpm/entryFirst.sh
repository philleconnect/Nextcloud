#!/bin/bash

echo 'installing and enabling apps'
sudo -u www-data php occ app:enable files_external
sudo -u www-data php occ app:install onlyoffice
sudo -u www-data php occ app:enable onlyoffice
sudo -u www-data php occ app:enable user_ldap
sudo -u www-data php occ ldap:create-empty-config

echo 'configuring nextcloud for PhilleConnect'
sed -i "s/TRUSTED_DOMAINS/$TRUSTED_DOMAINS/g" /var/www/config.json
sed -i "s/TRUSTED_PROXIES/$TRUSTED_PROXIES/g" /var/www/config.json
sed -i "s/NEXTCLOUD_DOMAIN/$NEXTCLOUD_DOMAIN/g" /var/www/config.json
sed -i "s/ONLYOFFICE_DOMAIN/$ONLYOFFICE_DOMAIN/g" /var/www/config.json
sed -i "s/LDAP_HOST/$LDAP_HOST/g" /var/www/config.json
sed -i "s/SLAPD_DOMAIN0/$SLAPD_DOMAIN0/g" /var/www/config.json
sed -i "s/SLAPD_DOMAIN1/$SLAPD_DOMAIN1/g" /var/www/config.json
sudo -u www-data php occ config:import /var/www/config.json

echo 'PhilleConnect-integration complete, starting php-fpm'

exec php-fpm
#exec /entrypoint.sh php-fpm
