# Basic nginx Configuration


## Rename original configuration file

    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.ORIG


## Create a new nginx configuration file using nano, with:
    nano /etc/nginx/nginx.conf

Paste (Ctrl-Shift-v in Gnome terminal, right-click in PuTTy) the following data into the file:

```
    user  www-data;
    worker_processes  auto;

    pid /run/nginx.pid;

    events {
        worker_connections  1024;
    }

    http {
        include       mime.types;
        default_type  application/octet-stream;

        #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
        #                  '$status $body_bytes_sent "$http_referer" '
        #                  '"$http_user_agent" "$http_x_forwarded_for"';
        error_log  /var/log/nginx_error.log error;
        #access_log  logs/access.log  main;

        sendfile        on;
        #tcp_nopush     on;

        keepalive_timeout  65;

        # SSL
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # no sslv3 (poodle etc.)
        ssl_prefer_server_ciphers on;

        # Gzip Settings
        gzip on;
        gzip_disable "msie6";
        gzip_vary on;
        gzip_min_length 512;
        gzip_types text/plain text/html application/x-javascript text/javascript application/javascript text/xml text/css application/font-sfnt;

        fastcgi_cache_path /usr/share/nginx/cache/fcgi levels=1:2 keys_zone=microcache:10m max_size=1024m inactive=1h;

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
    }
```


## Now create the cache directory:

    mkdir -p /usr/share/nginx/cache/fcgi

## Check for configuration errors

Test the nginx configuration (or attempt to reload nginx) to make sure you don't have any errors:

Test the configuration without restarting/reloading the nginx service:

```
nginx -t
```

Or reload nginx, if it's running and you want to apply the new configuration right away:

```
systemctl reload nginx
```

*Important*: When testing an nginx config, `[warn]`s are okay -- `[err]` means there's a problem that you need to troubleshoot and fix, and will prevent the nginx service from starting successfully.
