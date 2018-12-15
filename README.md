# NextCloud-Server with OnlyOffice-Integration

Nextcloud-Container including an online-office package (Collabora or Onlyoffice) that mounts the user-directories

# This optional container is still in beta-state! I have it set up in a productive environment, but expect some bugs, please report them!

## To install:

* Clone this repository: `git clone https://github.com/philleconnect/Nextcloud`. Make sure the cloned folder `Nextcloud` is in the same path like your `ServerContainers`-folder!
* Configure your installation by adapting the values in the `settings.env`. It won't work if you don't have a working domain set up! But for testing you can also enter your host-IP followed by the port 86, i.e. `192.168.0.100:86`.
* Call the Domain from any browser and you are set up! The first call and login might take a little while, espeacially if you get a 502 Bad Gateway error, please hang on for a few minutes, Nextcloud takes its time to set up!

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
