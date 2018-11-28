#!/bin/bash
echo "!!! WARNING !!! : This will DELETE ALL CUSTOM FILES of this Nextcloud-Installation!"
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    docker-compose stop
    docker rm onlyoffice
    docker rm nextcloud_fpm
    docker rm nextcloud_db
    docker rm nextcloud
    docker rmi nextcloud_onlyoffice
    docker rmi nextcloud_nextcloud_fpm
    docker rmi nextcloud_nextcloud_db
    docker rmi nextcloud_nextcloud
    docker volume rm nextcloud_nextcloud_db
    docker volume rm nextcloud_nextcloud_html
    docker volume rm nextcloud_onlyoffice_log
    docker volume rm nextcloud_onlyoffice_lib
    docker volume rm nextcloud_onlyoffice_sql
    docker volume rm nextcloud_onlyoffice_data
    docker volume rm nextcloud_onlyoffice_fonts
    echo "All docker-stuff has been deleted. You might want to execute 'git clean -f -d' to loose all user data and uncommitted changes as well."
else
    echo "Ok, I did't do anything, lucky you. Be careful!"
fi
