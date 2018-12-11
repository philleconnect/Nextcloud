#!/bin/bash

su -p www-data -s /bin/sh -c php occ app:install onlyoffice
su -p www-data -s /bin/sh -c php occ config:import < /config.json

source /entrypoint.sh
