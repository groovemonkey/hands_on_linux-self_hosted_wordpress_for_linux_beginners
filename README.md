# Hands-on Linux: Self-hosted WordPress for Linux Beginners

Code and configuration snippets for the [Hands-on Linux: Self-Hosted WordPress for Linux Beginners Course](https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/) course. Just navigate to whichever section you need help with.

To sign up for your own DigitalOcean account where you can provision a server to host your website and follow along with the course, use [this link](https://m.do.co/c/0380a1db56a6) (that link gives you a $100 account credit over 60 days, and I make $25 if you like DO and keep using them).

## Changelog:

#### December 2022
- New and improved MySQL root password / secure_installation instructions.

#### May 2022
- Packer Mini-Course Addition!
- Full course update for Ubuntu 22.04
- user creation is now more geared towards automation
- Small formatting and clarity improvements

#### July 2020
- updated instructions for Ubuntu 20.04
- nginx can now be installed from Ubuntu's package repositories, hooray!
- removed non-system instructions (it's been long enough now; we're not going back)
- cleaned up nginx docs
- cleaned up php-fpm docs, bumped version number, added explanation for why we keep the original www.conf pool file
- clean up php-fpm www.conf file after we create a site config file

#### December 2019:
- improve mysql instructions during the actual website setup
- use tutorialinux as the example site/user/database throughout the entire process

#### July 2019:
- overhaul the final, re-usable 'site setup' instructions: remove the confusion around separate username and site name; many beginners found this level of customization confusing.
- improve mysql password instructions
- add sudo in places where beginners forgot it
- remove 16.04 instructions

#### May 2019:
Reverting a change I made because it was over-optimizing for the end result (no www.conf 'default' php-fpm pool file). Now, no matter *where* in the course you are, you'll have a working php-fpm config and can safely restart/run the service -- even if you're not yet using it to run a PHP webapp.

#### January 2019:
Some fiddling with the php-fpm setup.

#### August 2018:
Update for php-fpm7.2 in Ubuntu 18.04. A plague on the Ubuntu package maintainers' houses!

#### July 2018:
MySQL syntax fixes, some formatting updates to make things easier to understand.

#### January 2018:
Many updates (see git commits) over the past few months. Most notably, Ubuntu 15.04 is now deprecated and has been removed from the instructions.

#### May 09, 2016:
Update instructions to work with Ubuntu 16.04, which introduces new major versions of the core application packages we use (PHP, mysql), along with several annoying bugs that we need to steer clear of.
