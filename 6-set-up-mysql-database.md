# 1. Create mysql root pass

    echo -n @ && cat /dev/urandom | env LC_CTYPE=C tr -dc [:alnum:] | head -c 15 && echo

You might notice the 'echo -n @' at the beginning. This is to get around the new password policy in MySQL version 5.5.6 and newer. Yes, it is predictable and the extra character doesn't add security, but it also doesn't make it any *less* secure. Being a sysadmin is also about being pragmatic.

# 2. Run mysql_secure_installation script

Delete anonymous user, remove test DB, set root passwd, etc. Answer “Y” to all questions.

    /usr/bin/mysql_secure_installation

# 3. Restart MySQL

    systemctl restart mysql
