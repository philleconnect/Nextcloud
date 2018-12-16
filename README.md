# NextCloud-Server with OnlyOffice-Integration

Nextcloud-Container including an online-office package (Collabora or Onlyoffice) that mounts the user-directories

# beta-testing!

This optional container is still in beta-state! I have it set up in a productive environment, but expect some bugs, please report them!

## To install:

* Clone this repository: `git clone https://github.com/philleconnect/Nextcloud`. Make sure the cloned folder `Nextcloud` is in the same path like your `ServerContainers`-folder!
* Configure your installation by adapting the values in the `settings.env`. It won't work if you don't have a working domain set up! But for testing you can also enter your host-IP followed by the port 86, i.e. `192.168.0.100:86`.
* Call the Domain from any browser and you are set up! The first call and login might take a little while, espeacially if you get a 502 Bad Gateway error, please hang on for a few minutes, Nextcloud takes its time to set up!

## How it works

This will build the Nextcloud-container among other containers (database, Office) in a separate virtual network. Since Nextcloud will most likely be made available from the Internet the isolated virtual network will provide extra security when there are security issues with Nextcloud. This is also why you need to suppy your LDAP-Server-IP.

The files are mounted to the Nextcloud-container as docker-volume. This only works out-of-the-box when this is executed on the same host (`Nextcloud`-folder nees to be in the same parent folder like `ServerContainers`). You can also run it on a separate host, but you will need to mount the samba-folder to that machine in some way.

If you want even more security/isolation you can also mount the user-folders as ftp-shares. You will then need the `ftpServer`-Container on your PhilleConnect-host and change the Settings for external files. But this solution is slower and user can't share files, so this is not the default.

All Settings (Nextcloud, Apps, Ldap, OnlyOffice etc.) are being prepared on container start (using the occ-command of Nextcloud), so you just need to make very few adaptions to your environment like entering your IP in the `settings.env`.

## Access from the Web

To access your installation from the web you might want to set up a proxy-Server, that can at the same time take care for the https-encryption.

This is my config for nginx that does the job:

```
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    ssl_certificate /etc/letsencrypt/live/nextcloud.mydomain.tld/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nextcloud.mydomain.tld/privkey.pem;
    server_name nextcloud.mydomain.tld;
    location / {
        proxy_set_header        Host                $host;
        proxy_set_header        X-Forwarded-Proto   https;
        proxy_set_header        X-Real-IP           $remote_addr;
        proxy_set_header        X-Forwarded-For     $proxy_add_x_forwarded_for;
        proxy_pass http://172.16.0.102:86/;
    }
}
```

Guess where my Let's Encryp certificate are, that certbot is getting.

Remember to have as well an according config for OnlyOffice pointing to port 82!

And make sure your have your proxy-IP in your `settings.env` as `TRUSTED_PROXIES`.
