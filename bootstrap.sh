#!/usr/bin/env bash
sudo apt-get update

sudo apt-get install -y gcc git autoconf build-essential

echo 'Installing Apache.'
sudo apt-get install -y apache2
sudo rm -rf /var/www
sudo ln -fs /vagrant /var/www

echo 'Installing PHP5.'
sudo apt-get install -y php5 libapache2-mod-php5
sudo a2enmod php5

echo 'Installing Postgresql.'
sudo apt-get install -y \
postgresql postgresql-contrib postgresql-client phppgadmin \
php5-pgsql php5-dev

echo 'Installing Phalcon.'
git clone git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install

echo 'extension=phalcon.so' | sudo tee -a /etc/php5/apache2/php.ini

service apache2 restart