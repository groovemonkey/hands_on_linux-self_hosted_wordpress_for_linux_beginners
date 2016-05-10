# Installing Required software for our Hosting Platform

On your Webserver (as root)

## Install software

    apt-get update

#### On Ubuntu 16.04 and later

At this point (May 2016), Ubuntu 16.04 is fairly unstable and requires a bit of special care. If you've upgraded your server's operating system from an older version of Ubuntu (i.e. you didn't create it as an Ubuntu 16.04 VM), the mysql upgrade may break things.

Make sure to install the mysql-server package FIRST (before installing the other packages):
    
    apt-get install mysql-server
    apt-get install php-mysql php-fpm monit

#### On Ubuntu 15.10 and before

    apt-get install mysql-server php5-mysql php5-fpm monit


## Install nginx's custom repository (PPA)

    add-apt-repository ppa:nginx/stable
    apt-get update
    apt-get install nginx


