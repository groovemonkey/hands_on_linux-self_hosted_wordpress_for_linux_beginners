# Managing Services with systemd

If you're logged in as the root user (or you've switched to the root user with `sudo -i` or `su - root`) then you don't need to prepend these commands with `sudo`, although it won't hurt anything.

## Start your services (and enable them at boot)

```
sudo systemctl start nginx php8.1-fpm monit
sudo systemctl enable mysql nginx php8.1-fpm monit
```
