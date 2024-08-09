# Installing Required software for our Hosting Platform

On your Webserver (as root)

## Install software

```bash
sudo apt update
sudo apt upgrade
```

Make sure to install the mysql-server package FIRST:

```bash
sudo apt install mysql-server
```

Now install the other packages we'll need for this course.

```bash
sudo apt install nginx php-mysql php-fpm monit
```

