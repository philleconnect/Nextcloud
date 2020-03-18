#!/bin/bash

echo 'installing and enabling apps'
sudo -u www-data php occ app:enable files_external
sudo -u www-data php occ app:install onlyoffice
sudo -u www-data php occ app:enable onlyoffice
sudo -u www-data php occ app:enable user_ldap
sudo -u www-data php occ ldap:create-empty-config
sudo -u www-data php occ app:install circles
sudo -u www-data php occ app:enable circles

echo 'configuring nextcloud for PhilleConnect'
cp -f /config.json.tpl /var/www/config.json
chown www-data /var/www/config.json
if [ $TESTING = true ]; then
    sed -i "s/TRUSTED_DOMAINS/\"localhost\",\"onlyoffice\",\"$LOCAL_IP_ADDRESS\"/g" /var/www/config.json
    sed -i "s/TRUSTED_PROXIES/\"localhost\",\"$LOCAL_IP_ADDRESS\"/g" /var/www/config.json
    sed -i "s/NEXTCLOUD_DOMAIN/$LOCAL_IP_ADDRESS\:86/g" /var/www/config.json
    sed -i "s/ONLYOFFICE_DOMAIN/$LOCAL_IP_ADDRESS\:82/g" /var/www/config.json
    sed -i "s/LDAP_HOST/$LOCAL_IP_ADDRESS/g" /var/www/config.json
    sed -i "s/PROTOCOL_PREFIX/http/g" /var/www/config.json
else
    sed -i "s/TRUSTED_DOMAINS/$TRUSTED_DOMAINS/g" /var/www/config.json
    sed -i "s/TRUSTED_PROXIES/$TRUSTED_PROXIES/g" /var/www/config.json
    sed -i "s/NEXTCLOUD_DOMAIN/$NEXTCLOUD_DOMAIN/g" /var/www/config.json
    sed -i "s/ONLYOFFICE_DOMAIN/$ONLYOFFICE_DOMAIN/g" /var/www/config.json
    sed -i "s/LDAP_HOST/$LDAP_HOST/g" /var/www/config.json
    sed -i "s/PROTOCOL_PREFIX/https/g" /var/www/config.json
fi
sed -i "s/SLAPD_DOMAIN0/$SLAPD_DOMAIN0/g" /var/www/config.json
sed -i "s/SLAPD_DOMAIN1/$SLAPD_DOMAIN1/g" /var/www/config.json
sudo -u www-data php occ config:import /var/www/config.json

sudo -u www-data php occ files_external:import /var/www/files_external.json

#sudo -u www-data php occ config:system:set skeletondirectory --value '/skeletondirectory'
rm -r /var/www/html/core/skeleton
cp -r /skeletondirectory /var/www/html/core/skeleton

# set max_children for php-fpm:
sed -i "s/PM_MAX_CHILDREN/$PM_MAX_CHILDREN/g" /usr/local/etc/php-fpm.d/www.conf

cp -r /var/www/lost_password.html /var/www/html/lost_password.html

# make sure created files can be edited from samba as well:
umask 0000

echo 'PhilleConnect-integration complete, starting php-fpm'

exec php-fpm
#exec /entrypoint.sh php-fpm
