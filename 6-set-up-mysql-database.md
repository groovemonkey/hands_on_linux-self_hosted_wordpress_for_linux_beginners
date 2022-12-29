# MySQL Setup

Perform the following actions as the root user.

## 1. Create mysql root pass

    echo -n @ && cat /dev/urandom | env LC_CTYPE=C tr -dc [:alnum:] | head -c 15 && echo

This password should pass the mysql validation plugin's requirements for a 'strong' password, should you choose to use that.

**SAVE THIS PASSWORD TO A TEXTFILE OR PASSWORD MANAGER RIGHT NOW! (not on your WordPress VM)**. You'll need it later.

*Note* You might notice the 'echo -n @' at the beginning of this password generation command. This is to get around the new password policy in MySQL version 5.5.6 and newer. Yes, it is predictable and the extra character doesn't add security, but it also doesn't make it any *less* secure. Being a sysadmin is also about being pragmatic.

## 2. Do some basic security config

Log into mysql as the root user. This will place you in a MySQL shell session.

```
sudo mysql
```

Change the root user's password -- replace "MYPASSWORD" with the strong password you generated in the previous step.

```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'MYPASSWORD';
```

Exit the MySQL shell with `ctrl-d`, or by typing

`exit`

and hitting ENTER.

## 3. Run the mysql_secure_installation script

    /usr/bin/mysql_secure_installation

Answer 'y' to all questions and set the password policy (second question) to 0-3 (whichever one you prefer; it doesn't really affect you in this course). If this is your first time through the course, you can set the password security to 0 to ensure mysql doesn't surprise you when you're testing/experimenting with passwords.

## 4. Restart MySQL

    systemctl restart mysql

This isn't strictly necessary, but it's good to practice working with services.
