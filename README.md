# Hands-on Linux: Self-hosted WordPress for Linux Beginners

Code and configuration snippets for the [Hands-on Linux: Self-Hosted WordPress for Linux Beginners Course](https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/) course. Just navigate to whichever section you need help with.

## Changelog:

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
