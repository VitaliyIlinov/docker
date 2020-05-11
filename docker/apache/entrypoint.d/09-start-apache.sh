#!/bin/bash
cp /docker/apache/apache.conf /etc/apache2/sites-enabled/000-default.conf.conf
cp /docker/php.ini /etc/php/${PHP_VERSION}/apache2/conf.d/custom.ini
a2enmod rewrite
source /etc/apache2/envvars
#tail -F /var/log/apache2/* &
#/usr/sbin/service apache2 start
exec apache2 -D FOREGROUND