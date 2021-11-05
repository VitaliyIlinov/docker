#!/bin/bash
a2enmod rewrite
source /etc/apache2/envvars
#tail -F /var/log/apache2/* &
#/usr/sbin/service apache2 start
exec apache2 -D FOREGROUND