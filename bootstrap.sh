#!/usr/bin/env bash
sudo apt-get update

sudo apt-get install -y gcc git autoconf build-essential curl

echo 'Installing Apache.'
sudo apt-get install -y apache2
sudo rm -rf /var/www
sudo ln -fs /vagrant /var/www

echo 'Installing PHP5.'
sudo apt-get install -y php5 libapache2-mod-php5
sudo a2enmod php5

echo 'Installing MySql.'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql php5-dev

echo 'Installing Phalcon.'
git clone git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install

echo 'extension=phalcon.so' | sudo tee -a /etc/php5/apache2/php.ini
echo 'extension=phalcon.so' | sudo tee -a /etc/php5/cli/php.ini

service apache2 restart

echo 'Installing Composer'
curl -s http://getcomposer.org/installer | php
sudo mv composer.phar /usr/bin/composer