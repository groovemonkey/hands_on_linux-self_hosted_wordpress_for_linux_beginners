# Set up database basics

    mysql_install_db


## Create mysql root pass

    cat /dev/urandom | env LC_CTYPE=C tr -dc a-zA-Z0-9 | head -c 14


## Run mysql_secure_installation script

Delete anonymous user, remove test DB, set root passwd, etc. Answer “Y” to all questions.

    /usr/bin/mysql_secure_installation

## Restart MySQL

    systemctl restart mysql


