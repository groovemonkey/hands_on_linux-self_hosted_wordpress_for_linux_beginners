# 1. (Ubuntu 15.10 and before only): set up database basics

You don't need to do this on Ubuntu 16.04.

    mysql_install_db

The rest of the instructions on this page will work regardless of your Ubuntu version.

# 2. Create mysql root pass

    echo -n @ && tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n1

You might notice the 'echo -n @' at the beginning. This is to get around the new password policy in MySQL version 5.5.6 and newer. Yes, it is predictable and the extra character doesn't add security, but it also doesn't make it any *less* secure. Being a sysadmin is also about being pragmatic.

# 3. Run mysql_secure_installation script

Delete anonymous user, remove test DB, set root passwd, etc. Answer “Y” to all questions.

    /usr/bin/mysql_secure_installation

# 4. Restart MySQL

    service mysql restart


