# Set up a WordPress Site

Replace all instances of 'yourusername' with the system username that you'll use for this site, and all instances of 'yoursitename' with the same. It makes sense to use a truncated version of your domain for both of these, e.g. for 'tutorialinux.com' I would use 'tutorialinux'.


## Create a system user for this site

    adduser yourusername # (go through add-user wizard, or use the 'useradd' command to do this noninteractively)
    mkdir -p /home/yourusername/logs


## Create nginx vhost config file

Add the following content to /etc/nginx/conf.d/yoursitename.conf. Replace all occurrences of '{{ domain_name }}' with your actual domain name for this site:

This is *different* for new versions of Ubuntu (16.04+) and older versions of Ubuntu (15.10 and before). The location of the PHP socket file has changed.


#### On Ubuntu 16.04 and after

    # nano /etc/nginx/conf.d/yoursitename.conf

    server {
        listen       80;
        server_name  www.{{ domain_name }};

        client_max_body_size 20m;

        index index.php index.html index.htm;
        root   /home/yourusername/public_html;

        location / {
            try_files $uri $uri/ /index.php?q=$uri&$args;
        }

        # pass the PHP scripts to FastCGI server
        location ~ \.php$ {
                # Basic
                try_files $uri =404;
                fastcgi_index index.php;

                # Create a no cache flag
                set $no_cache "";

                # Don't ever cache POSTs
                if ($request_method = POST) {
                  set $no_cache 1;
                }

                # Admin stuff should not be cached
                if ($request_uri ~* "/(wp-admin/|wp-login.php)") {
                  set $no_cache 1;
                }

                # WooCommerce stuff should not be cached
                if ($request_uri ~* "/store.*|/cart.*|/my-account.*|/checkout.*|/addons.*") {
                  set $no_cache 1;
                }

                # If we are the admin, make sure nothing
                # gets cached, so no weird stuff will happen
                if ($http_cookie ~* "wordpress_logged_in_") {
                  set $no_cache 1;
                }

                # Cache and cache bypass handling
                fastcgi_no_cache $no_cache;
                fastcgi_cache_bypass $no_cache;
                fastcgi_cache microcache;
                fastcgi_cache_key $server_name|$request_uri|$args;
                fastcgi_cache_valid 200 60m;
                fastcgi_cache_valid 404 10m;
                fastcgi_cache_use_stale updating;


                # General FastCGI handling
                fastcgi_pass unix:/var/run/php/yoursitename.sock;
                fastcgi_pass_header Set-Cookie;
                fastcgi_pass_header Cookie;
                fastcgi_ignore_headers Cache-Control Expires Set-Cookie;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_param SCRIPT_FILENAME $request_filename;
                fastcgi_intercept_errors on;
                include fastcgi_params;         
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico|woff|ttf|svg|otf)$ {
                expires 30d;
                add_header Pragma public;
                add_header Cache-Control "public";
                access_log off;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }

    server {
        listen       80;
        server_name  {{ domain_name }};
        rewrite ^/(.*)$ http://www.{{ domain_name }}/$1 permanent;
    }




#### On Ubuntu 15.10 and before

    # nano /etc/nginx/conf.d/yoursitename.conf

    server {
        listen       80;
        server_name  www.{{ domain_name }};

        client_max_body_size 20m;

        index index.php index.html index.htm;
        root   /home/yourusername/public_html;

        location / {
            try_files $uri $uri/ /index.php?q=$uri&$args;
        }

        # pass the PHP scripts to FastCGI server
        location ~ \.php$ {
                # Basic
                try_files $uri =404;
                fastcgi_index index.php;

                # Create a no cache flag
                set $no_cache "";

                # Don't ever cache POSTs
                if ($request_method = POST) {
                  set $no_cache 1;
                }

                # Admin stuff should not be cached
                if ($request_uri ~* "/(wp-admin/|wp-login.php)") {
                  set $no_cache 1;
                }

                # WooCommerce stuff should not be cached
                if ($request_uri ~* "/store.*|/cart.*|/my-account.*|/checkout.*|/addons.*") {
                  set $no_cache 1;
                }

                # If we are the admin, make sure nothing
                # gets cached, so no weird stuff will happen
                if ($http_cookie ~* "wordpress_logged_in_") {
                  set $no_cache 1;
                }

                # Cache and cache bypass handling
                fastcgi_no_cache $no_cache;
                fastcgi_cache_bypass $no_cache;
                fastcgi_cache microcache;
                fastcgi_cache_key $server_name|$request_uri|$args;
                fastcgi_cache_valid 200 60m;
                fastcgi_cache_valid 404 10m;
                fastcgi_cache_use_stale updating;


                # General FastCGI handling
                fastcgi_pass unix:/var/run/php-fpm/yoursitename.sock;
                fastcgi_pass_header Set-Cookie;
                fastcgi_pass_header Cookie;
                fastcgi_ignore_headers Cache-Control Expires Set-Cookie;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_param SCRIPT_FILENAME $request_filename;
                fastcgi_intercept_errors on;
                include fastcgi_params;         
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico|woff|ttf|svg|otf)$ {
                expires 30d;
                add_header Pragma public;
                add_header Cache-Control "public";
                access_log off;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }

    server {
        listen       80;
        server_name  {{ domain_name }};
        rewrite ^/(.*)$ http://www.{{ domain_name }}/$1 permanent;
    }




## Disable default nginx vhost (only the first time you set up a website)

    rm /etc/nginx/sites-enabled/default


## Create php-fpm vhost pool config file

Add the following content to a new php-fpm pool configuration file.

Replace all occurrences of "yoursitename" in the configuration file content below with your truncated domain name, and all occurrences of "yourusername" with the name of the system user you've created for this website.


#### On Ubuntu 16.04 and later

*On Ubuntu 16.04 and later* this file should be created at /etc/php/7.0/fpm/pool.d/yoursitename.conf

    [yoursitename]
    listen = /var/run/php/yoursitename.sock
    listen.owner = yourusername
    listen.group = www-data
    listen.mode = 0660
    user = yourusername
    group = www-data
    pm = dynamic
    pm.max_children = 75
    pm.start_servers = 8
    pm.min_spare_servers = 5
    pm.max_spare_servers = 20
    pm.max_requests = 500

    php_admin_value[upload_max_filesize] = 25M
    php_admin_value[error_log] = /home/yourusername/logs/phpfpm_error.log
    php_admin_value[open_basedir] = /home/yourusername:/tmp



#### On Ubuntu 15.10 and before

*On Ubuntu 15.10 and before* this file should be created at /etc/php5/fpm/pool.d/yoursitename.conf

    [yoursitename]
    listen = /var/run/php-fpm/yoursitename.sock
    listen.owner = yourusername
    listen.group = www-data
    listen.mode = 0660
    user = yourusername
    group = www-data
    pm = dynamic
    pm.max_children = 75
    pm.start_servers = 8
    pm.min_spare_servers = 5
    pm.max_spare_servers = 20
    pm.max_requests = 500

    php_admin_value[upload_max_filesize] = 25M
    php_admin_value[error_log] = /home/yourusername/logs/phpfpm_error.log
    php_admin_value[open_basedir] = /home/yourusername:/tmp



## On all versions of Ubuntu: Create the php-fpm logfile

    touch /home/yourusername/logs/phpfpm_error.log



## Create database + DB user

Log into your mysql database with the root account, using the password you created earlier (during the mysql_secure_installation script run):

    mysql -u root -p

This will prompt you for the MySQL root user’s password, and then give you a database shell. This shell will let you enter the following commands to create the WordPress database and user, along with appropriate permissions. Swap out ‘yoursite’ for your truncated domain name. This name can't contain any punctuation or special characters. Replace 'chooseapassword' with a strong password:

    CREATE DATABASE yoursite;
    CREATE USER yoursite@localhost;
    SET PASSWORD FOR yoursite@localhost= PASSWORD("chooseapassword");
    GRANT ALL PRIVILEGES ON yoursite.* TO yoursite@localhost IDENTIFIED BY 'chooseapassword';
    FLUSH PRIVILEGES;


Great; you’re done! Hit *ctrl-d* to exit the MySQL shell.




## Install WordPress

Now it's time to actually download and install the WordPress application.


### Download WordPress

    su - yourusername
    cd
    wget https://wordpress.org/latest.tar.gz


### Extract Wordpress Archive (+ Clean Up)

    tar zxf latest.tar.gz
    rm latest.tar.gz


### Rename the extracted 'wordpress' directory

    mv wordpress public_html


### Exit the unprivileged user's shell and become root again 

    ctrl-d (+ENTER)


### Set proper file permissions on your site files

    cd /home/yourusername/public_html
    chown -R yourusername:www-data .
    find . -type d -exec chmod 755 {} \;
    find . -type f -exec chmod 644 {} \;


## Restart your services

#### On Ubuntu 16.04 and newer

    systemctl restart php7.0-fpm nginx

#### On Ubuntu 15.10 or older

    service php5-fpm restart
    service nginx restart


## ONCE YOU HAVE RUN THE WORDPRESS INSTALLER...

You'll be able to run the installer by navigating to your server IP address in a browser. Once you've done that...

### Secure the wp-config.php file so other users can’t read DB credentials

    chmod 640 /home/yourusername/public_html/wp-config.php


