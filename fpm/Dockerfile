FROM nextcloud:14-fpm

MAINTAINER Dirk Winkel <it@polarwinkel.de>

#RUN apt-get update && apt-get install -y --no-install-recommends smbclient

#USER root
#RUN echo "*/15 * * * * php-nextcloud php -f /srv/www/nextcloud/cron.php" > /etc/cron.d/9999nextcloud
#RUN service php7.0-fpm start
COPY config.json /config.json
COPY entryFirst.sh /entryFirst.sh
RUN chmod +x /entryFirst.sh

#USER www-data

WORKDIR "/var/www/html"
#RUN run_as 'php occ maintenance:mode --on'
# Database-setup is done via env-variables by the stock nextcloud-container

##RUN php occ config:app:set core backgroundjobs_mode --value="cron"
#RUN php occ app:enable files_external
#RUN php occ app:enable user_ldap && \
#        php occ ldap:create-empty-config && \
#        php occ ldap:set-config s01 ldapHost "172.16.0.102" && \
#        php occ ldap:set-config s01 ldapBase "dc=ldap,dc=schoolconnect"

#RUN php occ app:install onlyoffice && php occ app:enable onlyoffice
#RUN php occ config:system:set trusted_domains 1 --value="nextcloud.my.domain"
#RUN php occ config:system:set overwrite.cli.url --value="https://nextcloud.my.domain"
#RUN php occ config:system:set remember_login_cookie_lifetime --value="2700" --type=integer
##RUN php occ config:app:set files default_quota --value="1 GB"
##RUN php occ maintenance:mode --off

WORKDIR "/"
ENTRYPOINT ["/bin/bash"]
CMD ["/entryFirst.sh"]
