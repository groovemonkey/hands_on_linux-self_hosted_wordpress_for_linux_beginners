# Managing Services with systemd

If you're logged in as the root user (or you've switched to the root user with `sudo -i` or `su - root`) then you don't need to prepend these commands with `sudo`, although it won't hurt anything.

## Start your services (and enable them at boot)

#### On Ubuntu 18.04

    sudo systemctl start nginx php7.2-fpm monit
    sudo systemctl enable mysql nginx php7.2-fpm monit

#### On Ubuntu 16.04

    sudo systemctl start nginx php7.0-fpm monit
    sudo systemctl enable mysql nginx php7.0-fpm monit

### Old syntax (for systems not using systemd)

    sudo service <service> <action>
    sudo service mysql status
    sudo service nginx enable
