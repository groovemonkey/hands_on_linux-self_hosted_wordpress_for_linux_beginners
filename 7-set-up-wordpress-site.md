# Set up a WordPress Site

Replace all instances of 'tutorialinux' with the system username that you'll use for this site. It makes sense to use a truncated version of your domain for this, e.g. for 'tutorialinux.com' I would use 'tutorialinux'.


## Create a system user for this site
I'm using the username 'tutorialinux' in all of these examples, but you can change it to something that reflects your website's name

    export WEBSITEUSER=tutorialinux
    
    useradd -s /bin/bash -m -d /home/$WEBSITEUSER $WEBSITEUSER
    mkdir -p /home/$WEBSITEUSER/logs


### Ensure permissions are set properly on the home directory
This will make sure your nginx AND php processes can read all website-related files in your website-user's home directory:

    chown -R $WEBSITEUSER:www-data /home/$WEBSITEUSER
    chmod 775 /home/$WEBSITEUSER


## Create nginx vhost config file

Add the following content to /etc/nginx/conf.d/tutorialinux.conf. Replace all occurrences of 'tutorialinux' in this file with your IP address or domain name (if you have one):

    # nano /etc/nginx/conf.d/tutorialinux.conf

```
server {
    listen       80;
    server_name  www.tutorialinux.com;

    client_max_body_size 20m;

    index index.php index.html index.htm;
    root   /home/tutorialinux/public_html;

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
            fastcgi_cache_key $scheme$request_method$server_name$request_uri$args;
            fastcgi_cache_valid 200 60m;
            fastcgi_cache_valid 404 10m;
            fastcgi_cache_use_stale updating;


            # General FastCGI handling
            fastcgi_pass unix:/var/run/php/tutorialinux.sock;
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
    server_name  tutorialinux.com;
    rewrite ^/(.*)$ http://www.tutorialinux.com/$1 permanent;
}
```


## Disable default nginx vhost (only the first time you set up a website)

    rm /etc/nginx/sites-enabled/default


## Create php-fpm vhost pool config file

Add the following content to a new php-fpm pool configuration file:

```
nano /etc/php/8.1/fpm/pool.d/tutorialinux.conf
```

Replace all occurrences of "tutorialinux" in the configuration file content below with your site name.

```
[tutorialinux]
listen = /var/run/php/tutorialinux.sock
listen.owner = tutorialinux
listen.group = www-data
listen.mode = 0660
user = tutorialinux
group = www-data
pm = dynamic
pm.max_children = 75
pm.start_servers = 8
pm.min_spare_servers = 5
pm.max_spare_servers = 20
pm.max_requests = 500

php_admin_value[upload_max_filesize] = 25M
php_admin_value[error_log] = /home/tutorialinux/logs/phpfpm_error.log
php_admin_value[open_basedir] = /home/tutorialinux:/tmp
```

## Clean up the original php-fpm pool config file
We've kept this around just to prevent errors while restarting php-fpm. Since we just created a new php-fpm pool config file, let's clean the old one up:

    rm /etc/php/8.1/fpm/pool.d/www.conf


## Create the php-fpm logfile

    sudo -u tutorialinux touch /home/tutorialinux/logs/phpfpm_error.log


## Create Site Database + DB User

First, create a new mysql password for your wordpress site. You can do this in any Linux shell, local or remote:

    # Create password
    echo -n @ && cat /dev/urandom | env LC_CTYPE=C tr -dc [:alnum:] | head -c 15 && echo

Now log into your mysql database with the root account, using the password you created and saved earlier (during the mysql_secure_installation script run):

    mysql -u root -p

This will prompt you for the MySQL root user’s password, and then give you a database shell. This shell will let you enter the following commands to create the WordPress database and user, along with appropriate permissions. Swap out ‘yoursite’ for your truncated domain name. This name can't contain any punctuation or special characters.

Replace `chooseapassword` with the strong password that you just created with the shell command above, and `tutorialinux` with your site name.

```
# Log into mysql
CREATE DATABASE tutorialinux;
CREATE USER 'tutorialinux'@'localhost' IDENTIFIED BY 'chooseapassword';
GRANT ALL PRIVILEGES ON tutorialinux.* TO tutorialinux@localhost;
FLUSH PRIVILEGES;
```

Great; you’re done! Hit *ctrl-d* to exit the MySQL shell.



## Install WordPress

Now it's time to actually download and install the WordPress application.


### Download WordPress

Become your site user (named tutorialinux in my case) and download the WordPress application:

    su - tutorialinux
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

Make sure you're in your user's home/public_html directory. I'm still using the WEBSITEUSER variable that we set earlier -- in my case it's set to `tutorialinux`:

```
cd /home/$WEBSITEUSER/public_html
chown -R $WEBSITEUSER:www-data .
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
```

## Restart your services

    systemctl restart php8.1-fpm
    systemctl restart nginx


## Optional: Set up DNS
Log into your registrar's dashboard (wherever you purchased your domain name, usually) and point your domain at the WordPress server's IP.


## Open the WordPress Installer in your Browser
Use your browser to navigate to the wordpress install page at http://example.com/wp-admin/setup-config.php (replace example.com with your chosen domain name).

If you don't have a domain name yet (or it's not set up with an A record to point at your server's IP address), then use this trick to 'fake' it on your local machine.

Make these changes on the local Linux machine you're using as a 'base' to go through this course, **not* on your remote web server that's running the WordPress site**:

```
nano /etc/hosts
```
Add two lines like the following, with the IP and hostnames replaced by your WordPress server's IP address and your domain name, respectively:
```
1.2.3.4    tutorialinux.com
1.2.3.4    www.tutorialinux.com
```

This will trick applications (only on the local machine) to use this mapping, INSTEAD of the public DNS system, to resolve your hostname.

It's a great way of testing things locally, before modifying DNS records at your domain registrar (e.g. namecheap).


## ONCE YOU HAVE RUN THE WORDPRESS INSTALLER...

You'll be able to run the installer by navigating to your server IP address in a browser. Once you've done that...

### Secure the wp-config.php file so other users can’t read DB credentials

    chmod 640 /home/tutorialinux/public_html/wp-config.php
