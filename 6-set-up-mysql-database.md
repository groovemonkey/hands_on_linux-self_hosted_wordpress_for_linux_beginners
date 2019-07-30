# MySQL Setup

Perform the following actions as the root user.

## 1. Create mysql root pass

    echo -n @ && cat /dev/urandom | env LC_CTYPE=C tr -dc [:alnum:] | head -c 15 && echo

**SAVE THIS PASSWORD TO A TEXTFILE OR PASSWORD MANAGER RIGHT NOW! (not on your WordPress VM)**. You'll need it later.

*Note* You might notice the 'echo -n @' at the beginning of this password generation command. This is to get around the new password policy in MySQL version 5.5.6 and newer. Yes, it is predictable and the extra character doesn't add security, but it also doesn't make it any *less* secure. Being a sysadmin is also about being pragmatic.

## 2. Run mysql_secure_installation script

Delete anonymous user, remove test DB, set root passwd, etc.

    /usr/bin/mysql_secure_installation

Answer 'y' to all questions and set the password policy (second question) to 0-3 (whichever one you prefer). If this is your first time through the course, set the password security to 0 to ensure mysql doesn't surprise you when you're testing/experimenting.

## 3. Restart MySQL

    systemctl restart mysql
