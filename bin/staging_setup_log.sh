#!/usr/bin/env bash

# Generate and exchange SSH key
# http://www.linuxproblem.org/art_9.html

sudo apt-get install git nodejs npm postgresql postgresql-contrib postgresql-server-dev-all


# Add user
sudo adduser school_deploy
sudo usermod -a -G sudo school_deploy

# app dir
sudo mkdir /var/www/school-management

# and give new user access
sudo chown school_deploy:school_deploy /var/www/school-management

# install ruby-install
# https://github.com/postmodern/ruby-install#readme
wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd ruby-install-0.5.0/
sudo make install

ruby-install ruby 2.2.3


# install chruby
# https://github.com/postmodern/chruby
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install

#sudo ./scripts/setup.sh

source /usr/local/share/chruby/chruby.sh


# install postgresql
# https://help.ubuntu.com/community/PostgreSQL

#sudo apt-get install postgresql postgresql-contrib  postgresql-server-dev-all
sudo -u postgres psql postgres
\password postgres
CREATE EXTENSION adminpack;

# update postgres to 9.4
# https://wiki.postgresql.org/wiki/Apt#Quickstart
sudo apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
# sudo apt-get upgrade
sudo apt-get install postgresql-9.4 pgadmin3

sudo /etc/init.d/postgresql stop
sudo vi /etc/postgresql/9.4/main/postgresql.conf
# change port to 5432
sudo /etc/init.d/postgresql start 9.4


# Notes

# hosteurope

# Plesk stoppen oder deinstallieren
# (http://syscfg.net/blog/posts/Host_Europe_vServer_Plesk_deinstallieren)
/etc/init.d/psa stopall

# Apache stoppen und Autostart deaktivieren
/etc/init.d/apache2 stop
update-rc.d -f apache2 remove
