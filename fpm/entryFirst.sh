#!/bin/bash

su -p www-data -s /bin/sh -c php occ app:install onlyoffice
su -p www-data -s /bin/sh -c php occ config:import < /config.json

exec /entrypoint.sh php-fpm
