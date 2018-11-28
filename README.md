# NextCloud-Server with OnlyOffice-Integration
Nextcloud-Container including an online-office package (Collabora or Onlyoffice) that mounts the user-directories

# !!! THIS IS STILL IN ALPHA-STATE !!!

## To install:

* start the containers
* manually add `'onlyoffice'` to the `trusted_domains`-array in `/var/www/html/config/config.php` (inside the nextcloud-container):
  - `docker exec -ti nextcloud /bin/bash`
  - `nano /var/www/html/config/config.php`
  - add line `    1 => 'onlyoffice',` after line 23
  - optionally add a line `  'trusted_proxies' => ['172.16.0.102', 'philleconnect'],` after the trusted domains (see also below)

## connect to LDAP

activate LDAP-App and in the settings for it:

* add ldap-Server-address (=philleconnect-Server) like `172.16.0.102`
* add `cn=admin,dc=ldap,dc=philleconnect` and password, base-dn should fill in to `dc=ldap,dc=philleconnect` and test should succeed
* on the next page "user" for `inetOrgPerson` the ldap-filter might get configured to `(|(objectclass=inetOrgPerson))`, if it does not do it by hand
* the login-attribures might get filled with `(&(|(objectclass=inetOrgPerson))(uid=%uid))`, if not do it by hand
* for the groups select `students` and `teachers`
* in the advanced-settings type in `cn` for the displayName (folder settings) and the name of the home-folder (special settings)

## OnlyOffice

activate app for OnlyOffice and set it up in the settings:

* someting like `http://172.16.0.100:82/` (or `onlyoffice.my-domain.tld` if you run it under that domain) in the first field 
* `http://onlyoffice/` for internal document editing
* `https://nextcloud.my-domain.tld` for external editing
* the adress needs to be in the trusted domains (see above)!

## behind proxy

If you run this behind a proxy, i.e. to make it accessible from the web, maybe with a https-secured connection, you might need to add these parameters to the `/var/www/html/config/config.php`:

```
  'trusted_proxies' => 
  array (
    0 => '172.16.0.102',
    1 => 'philleconnect',
  ),
  'overwrite.cli.url' => 'https://nextcloud.my-domain.tld',
  'overwritehost'     => 'nextcloud.my-domain.tld',
```

My working nginx-config looks like this:

```
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    ssl_certificate /etc/letsencrypt/live/nextcloud.my-domain.tld/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nextcloud.my-domain.tld/privkey.pem;
    server_name nextcloud.my-domain.tld;
    location / {
        proxy_set_header        X-Forwarded-Proto   https;
        proxy_set_header        X-Real-IP           $remote_addr;
        proxy_set_header        X-Forwarded-For     $proxy_add_x_forwarded_for;
        proxy_pass http://172.16.0.100:86/;
    }
}
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    ssl_certificate /etc/letsencrypt/live/onlyoffice.my-domain.tld/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/onlyoffice.my-domain.tld/privkey.pem;
    server_name onlyoffice.my-domain.tld;
    location / {
        proxy_set_header        Host                $host;
        proxy_set_header        X-Forwarded-Proto   https;
        proxy_set_header        X-Real-IP           $remote_addr;
        proxy_set_header        X-Forwarded-For     $proxy_add_x_forwarded_for;
        proxy_pass http://172.16.0.100:82/;
    }
}
```

Just use your own domains and your own IPs!


## Samba-Shares

There is still a problem mounting the samba-shares which might be a recent bug in nextcloud. The cpu-load explodes when mounting samba-shares, so this will come later.
Try with:

* activate app for external storage support and
* set up your folders:
** choose `SMB/CIFS`
** test with "username and password"
** for production "save login in session" is what you want

Please be aware that, when setting up shares as the Nextcloud-admin, you can only reach them as an according LDAP-user, so those errors can be ignored during setup.
