#!/usr/bin/env bash
set -eu

# From https://github.com/groovemonkey/hands_on_linux-self_hosted_wordpress_for_linux_beginners/blob/master/7-set-up-wordpress-site.md

# Replace all instances of 'tutorialinux' with the system username that you'll use for this site. It makes sense to use a truncated version of your domain for this, e.g. for 'tutorialinux.com' I would use 'tutorialinux'.
BASENAME=tutorialinux
PACKER_LOGFILE=/etc/packer-setup.log
echo "PACKER SETUP SCRIPT: STARTING!" | sudo tee -a $PACKER_LOGFILE


## User creation

sudo useradd -s /bin/bash -m -d /home/$BASENAME $BASENAME
sudo mkdir -p /home/$BASENAME/logs
sudo chown -R $BASENAME:www-data /home/$BASENAME

# TODO don't need this anymore?
# chmod 775 /home/$BASENAME


## php-fpm

# Create the php-fpm logfile, as the website user
sudo -u ${BASENAME} touch /home/${BASENAME}/logs/phpfpm_error.log

# Cleanup old pool conf
sudo rm /etc/php/8.1/fpm/pool.d/www.conf


## Database

# Create Site Database + DB User
# Create password
MYPASS=$(echo -n @ && cat /dev/urandom | env LC_CTYPE=C tr -dc [:alnum:] | head -c 15 && echo)
# TODO does this echo in a visible place for the packer run?
echo
echo
echo PACKER SETUP SCRIPT: YOUR MYSQL PASS IS: $MYPASS | sudo tee -a $PACKER_LOGFILE
echo
echo

# Log into mysql and run commands
# TODO did password interpolation work?
sudo mysql -u root << EOF
CREATE DATABASE ${BASENAME};
CREATE USER '${BASENAME}'@'localhost' IDENTIFIED BY '${MYPASS}';
GRANT ALL PRIVILEGES ON ${BASENAME}.* TO ${BASENAME}@localhost;
FLUSH PRIVILEGES;
EOF


## Install WordPress
wget --quiet https://wordpress.org/latest.tar.gz
tar zxf latest.tar.gz
rm latest.tar.gz
sudo mv wordpress /home/${BASENAME}/public_html

sudo chown -R ${BASENAME}:www-data /home/${BASENAME}/public_html
sudo find /home/${BASENAME}/public_html -type d -exec chmod 755 {} \;
sudo find /home/${BASENAME}/public_html -type f -exec chmod 644 {} \;


echo "$(date) - PACKER SETUP SCRIPT: SUCCESS!" | sudo tee -a $PACKER_LOGFILE
exit 0
