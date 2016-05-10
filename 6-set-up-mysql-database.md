# On Ubuntu 15.10 and before: set up database basics

You don't need to do this on Ubuntu 16.04.

    mysql_install_db


## Create mysql root pass

    cat /dev/urandom | env LC_CTYPE=C tr -dc a-zA-Z0-9 | head -c 14 && echo


## Run mysql_secure_installation script

Delete anonymous user, remove test DB, set root passwd, etc. Answer “Y” to all questions.

    /usr/bin/mysql_secure_installation

## Restart MySQL

    systemctl restart mysql


