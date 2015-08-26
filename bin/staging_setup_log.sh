#!/usr/bin/env bash

# Generate and exchange SSH key
# http://www.linuxproblem.org/art_9.html

sudo apt-get install git nodejs npm postgresql postgresql-contrib postgresql-server-dev-all


# Add user
sudo adduser school_management_deploy
sudo usermod -a -G sudo school_management_deploy

# app dir
sudo mkdir /var/www/school-management

# and give new user access
sudo chown school_management_deploy:school_management_deploy /var/www/school-management


# install chruby
# https://github.com/postmodern/chruby
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install

#sudo ./scripts/setup.sh

# install ruby-install
# https://github.com/postmodern/ruby-install#readme
wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd ruby-install-0.5.0/
sudo make install

source /usr/local/share/chruby/chruby.sh


# install postgresql
# https://help.ubuntu.com/community/PostgreSQL

#sudo apt-get install postgresql postgresql-contrib  postgresql-server-dev-all
sudo -u postgres psql postgres
\password postgres
CREATE EXTENSION adminpack;

