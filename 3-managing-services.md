# Managing Services with systemd


## Start your services (and enable them at boot)

#### On Ubuntu 16.04 and later

    systemctl start nginx php7.0-fpm monit
    systemctl enable mysql nginx php7.0-fpm

#### On Ubuntu 15.10 and earlier

    systemctl start nginx php5-fpm monit
    systemctl enable mysql nginx php5-fpm monit


### Old syntax (for systems not using systemd, like Ubuntu 14.04 and others)

    service <service> <action>
    service mysql status
    service nginx enable
