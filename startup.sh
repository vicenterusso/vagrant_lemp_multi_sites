#!/usr/bin/env bash


sudo sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php5/fpm/php.ini
sudo sed -i 's/; max_input_vars = .*/max_input_vars = 3000/' /etc/php5/fpm/php.ini
sudo sed -i 's/max_execution_time = .*/max_execution_time = 300/' /etc/php5/fpm/php.ini
sudo sed -i 's/upload_max_filesize = .*/upload_max_filesize = 64M/' /etc/php5/fpm/php.ini


sudo service mysql restart
sudo service nginx restart
sudo service php5-fpm restart