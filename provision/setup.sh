#!/bin/bash
echo "Provisioning virtual machine..."

sudo apt-get update
sudo apt-get install -y apt build-essential git htop

echo "Installing Nginx"
sudo apt-get install -y nginx

echo "Preparing MySQL"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'

echo "Installing MySQL"
sudo apt-get -y install mysql-server

echo "Creating database and user"
mysql -uroot -ppass -e "create database blog";
mysql -uroot -ppass -e "CREATE USER 'webapp'@'localhost' IDENTIFIED BY 'password'";
mysql -uroot -ppass -e "GRANT ALL PRIVILEGES ON blog.* TO 'webapp'@'localhost'";

echo "Updating PHP repository"
sudo apt-get install -y python-software-properties
sudo LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
sudo apt-get update

echo "Installing PHP"
sudo apt-get install -y php7.0 php7.0-fpm php7.0-mysql php7.0-mbstring php7.0-xml php7.0-zip
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.0/fpm/php.ini
sudo service php7.0-fpm restart

echo "Installing Composer"
cd ~
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

echo "Configuring Nginx"
sudo cp ~/project/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost
sudo ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
sudo rm -rf /etc/nginx/sites-available/default
sudo service nginx restart
