# Monitoring with Monit

Edit the main config file at /etc/monit/monitrc

Content:

    set daemon  30
    set logfile /var/log/monit.log
    set alert user@example.org

    set httpd
        port 2812
        use address localhost  # only accept connection from localhost
        # allow localhost        # allow localhost to connect to the server and
        allow youruser:yourpassword

    # Check nginx
    # Try writing an nginx config using the other examples in this file!
    ## check process nginx with pidfile <yournginxpidfile>
    ## if failed...

    # Check MySQL
    check host localmysql with address 127.0.0.1
          if failed ping then alert        
          if failed port 3306 protocol mysql then alert

    # Check php-fpm
    check process phpfpm with pidfile /run/php/php7.0-fpm.pid
          if cpu > 50% for 2 cycles then alert
          # if total cpu > 60% for 5 cycles then restart
          if memory > 300 MB then alert
          # if total memory > 500 MB then restart


    # include files for individual sites
    include /etc/monit.d/*



That's your base file. Now, let's add some site files at /etc/monit.d/
For your first website, add a file named yoursitename.cnf, e.g. tutorialinux.cnf

    # Site monitoring fragment for tutorialinux.com
    check host tutorialinux.com with address tutorialinux.com
        if failed port 80 protocol http for 2 cycles then alert

    check file access.log with path /var/www/tutorialinux/sites/tutorialinux.com/error_log
        if size > 15 MB then exec "/usr/local/sbin/logrotate -f /var/www/tutorialinux/sites/tutorialinux.com/error_log"


Restart monit and you're good to go!

    service monit restart
    systemctl restart monit
