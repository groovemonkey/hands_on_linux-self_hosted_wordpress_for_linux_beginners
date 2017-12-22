# Installing Required software for our Hosting Platform

On your Webserver (as root)

## Install software

    apt-get update

Make sure to install the mysql-server package FIRST (before installing the other packages):
    
    apt-get install mysql-server
    apt-get install php-mysql php-fpm monit

## Install nginx's custom repository (PPA)

    add-apt-repository ppa:nginx/stable
    apt-get update
    apt-get install nginx
