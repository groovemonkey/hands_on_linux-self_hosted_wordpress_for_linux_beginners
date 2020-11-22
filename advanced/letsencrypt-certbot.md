# You should serve your site over HTTPS!
That requires a TLS (Transport-Layer Security -- used to be called Secure Sockets Layer, or SSL) certificate.

Thankfully these are free now -- they used to cost hundreds of dollars per year.

Here's all you need to do to request SSL certs for the domains you are running on your server.
*Note* This will only work if you own real, public domains and have pointed them at your web server's IP using A records.

## Install certbot and the nginx plugin

    sudo apt install certbot python3-certbot-nginx

## Run the automatic configuration wizard
This will detect the domains you have nginx configs for on your server (even if you have multiple websites set up!) and automatically request/configure TLS certs for you.
*Note* This will modify your nginx config, so make a backup before you do this:

    sudo certbot --nginx

## Renewal
Renewal is automatic by default -- installing certbot creates an automatic renewal script in /etc/cron.d/certbot
Double-check to make sure it's there, and if you're worried that renewals will fail for some reason, just do a dry run:

    sudo certbot renew --dry-run
    
Have fun with your new, more secure website! Your users (and your Google rankings) will thank you.
