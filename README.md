# NextCloud-Server with OnlyOffice-Integration
Nextcloud-Container including an online-office package (Collabora or Onlyoffice) that mounts the user-directories

# !!! THIS IS STILL IN ALPHA-STATE !!!

To install:

* start the containers
* manually add `'onlyoffice'` to the `trusted_domains`-array in `/var/www/html/config/config.php` (inside the nextcloud-container)
* set up nextcloud according to the pdf-files in this folder
