# Managing Services with systemd


## Start your services (and enable them at boot)

#### On Ubuntu 18.04

    systemctl start nginx php7.2-fpm monit
    systemctl enable mysql nginx php7.2-fpm monit

#### On Ubuntu 16.04

    systemctl start nginx php7.0-fpm monit
    systemctl enable mysql nginx php7.0-fpm monit

### Old syntax (for systems not using systemd)

    service <service> <action>
    service mysql status
    service nginx enable
