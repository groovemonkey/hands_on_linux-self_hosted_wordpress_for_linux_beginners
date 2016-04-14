# Managing Services with systemd


## Start your services (and enable them at boot)

    systemctl start nginx php5-fpm monit
    systemctl enable mysql nginx php5-fpm monit


## Old syntax (for systems not using systemd)

    service <service> <action>
    service mysql status
    service nginx enable
