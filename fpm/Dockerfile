FROM nextcloud:15-fpm

MAINTAINER Dirk Winkel <it@polarwinkel.de>

#RUN apt-get update && apt-get install -y --no-install-recommends smbclient
RUN apt-get update && apt-get install -y --no-install-recommends sudo

COPY config.json.tpl /config.json.tpl
RUN chown www-data:root /config.json.tpl
COPY files_external.json /var/www/files_external.json
RUN chown www-data:root /var/www/files_external.json
COPY entryFirst.sh /entryFirst.sh
RUN chmod +x /entryFirst.sh
RUN sed -i 's\^exec "$@"\exec /entryFirst.sh\g' /entrypoint.sh

COPY skeletondirectory /skeletondirectory
RUN chown -R www-data:root /skeletondirectory
COPY lost_password.html lost_password.html
RUN chown -R www-data:root lost_password.html

#RUN echo "*/15 * * * * php-nextcloud php -f /srv/www/nextcloud/cron.php" > /etc/cron.d/9999nextcloud
##RUN php occ config:app:set core backgroundjobs_mode --value="cron"
#RUN php occ app:enable files_external
#RUN php occ app:enable user_ldap && \
#        php occ ldap:create-empty-config && \
#        php occ ldap:set-config s01 ldapHost "172.16.0.102" && \
#        php occ ldap:set-config s01 ldapBase "dc=ldap,dc=schoolconnect"
#RUN php occ config:system:set remember_login_cookie_lifetime --value="2700" --type=integer
#RUN php occ config:app:set files default_quota --value="1 GB"
