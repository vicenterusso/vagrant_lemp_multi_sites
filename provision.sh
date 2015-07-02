#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

sudo aptitude update -q

echo "Provisioning"

echo "Force a blank root password for mysql"
# Force a blank root password for mysql
echo "mysql-server mysql-server/root_password password " | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password " | debconf-set-selections

echo "Installing mysql, nginx, php5-fpml"
# Install mysql, nginx, php5-fpm
apt-get install -q -y -f mysql-server mysql-client nginx php5-fpm

echo "Install commonly used php packages"
# Install commonly used php packages
sudo aptitude install -q -y -f php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xcache

echo "Configuring MySQL"
#Mysql
for d in "/vagrant/db/"*
do
	if [ ! -f "$d/created" ]; then		
		mysql -uroot <<< "DROP DATABASE IF EXISTS $(basename "$d")"
		mysql -uroot <<< "CREATE DATABASE $(basename "$d")"
		if [ -f "$d/dump.sql" ]; then
			mysql -uroot $(basename "$d") < $d/dump.sql
		fi
		sudo touch $d/created
	fi
done

echo "Configuring NGINX"
#Nginx
conf="/vagrant/nginx_template/nginx-vhost-template.conf"
for d in "/vagrant/nginx_template/"*/
do
	f=$(basename "$d")
	if [ ! -f "$d/created" ]; then
		destconf=/etc/nginx/sites-enabled/$f.conf
		sudo cp $conf $destconf
		sudo sed -i -- "s/{{DOMAIN}}/$f/g" $destconf
		sudo touch $d/created
	fi
done


