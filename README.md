# NextCloud-Server with OnlyOffice-Integration
Nextcloud-Container including an online-office package (Collabora or Onlyoffice) that mounts the user-directories

# !!! THIS IS STILL IN ALPHA-STATE !!!

## To install:

* start the containers
* manually add `'onlyoffice'` to the `trusted_domains`-array in `/var/www/html/config/config.php` (inside the nextcloud-container):
  - `docker exec -ti nextcloud /bin/bash`
  - `nano /var/www/html/config/config.php`
  - add line `    1 => 'onlyoffice',` after line 23
  - optionally add a line `  'trusted_proxies' => ['172.16.0.102', 'philleconnect'],` after the trusted domains

## connect to LDAP

activate LDAP-App and in the settings for it:

* add ldap-Server-address (=philleconnect-Server) like `172.16.1.44`
* add `cn=admin,dc=ldap,dc=philleconnect` and password, base-dn should fill in to `dc=ldap,dc=philleconnect` and test should succeed
* on the next page "user" for `inetOrgPerson` the ldap-filter might get configured to `(|(objectclass=inetOrgPerson))`, if it does not do it by hand
* the login-attribures might get filled with `(&(|(objectclass=inetOrgPerson))(uid=%uid))`, if not do it by hand
* for the groups select `students` and `teachers`
* in the advanced-settings type in `cn` for the displayName (folder settings) and the name of the home-folder (special settings)

## OnlyOffice

activate app for OnlyOffice and set it up in the settings:

* someting like `http://172.16.1.44:42/` in the first field 
* `http://onlyoffice/` for internal document editing
* someting like `http://172.16.1.44:86/` for external editing
* the adress needs to be in the trusted domains (see above)!

## Samba-Shares

There is still a problem mounting the samba-shares which might be a recent bug in nextcloud. The cpu-load explodes when mounting samba-shares, so this will come later.
Try with:

* activate app for external storage support and
* set up your folders:
** choose `SMB/CIFS`
** test with "username and password"
** for production "save login in session" is what you want

Please be aware that, when setting up shares as the Nextcloud-admin, you can only reach them as an according LDAP-user, so those errors can be ignored during setup.
