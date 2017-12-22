# Managing Services with systemd


## Start your services (and enable them at boot)

#### On Ubuntu 16.04 and later

    systemctl start nginx php7.0-fpm monit
    systemctl enable mysql nginx php7.0-fpm monit

### Old syntax (for systems not using systemd)

    service <service> <action>
    service mysql status
    service nginx enable
