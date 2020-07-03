# Installing Required software for our Hosting Platform

On your Webserver (as root)

## Install software

    apt-get update
    apt-get upgrade

Make sure to install the mysql-server package FIRST (before installing the other packages):
    
    apt-get install mysql-server
    apt-get install nginx php-mysql php-fpm monit
