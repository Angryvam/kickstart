#!/bin/bash

set -e

apt-get install apache2 libapache2-mod-php7.0

rm -R /var/www/html
ln -s /opt/www /var/www/html
