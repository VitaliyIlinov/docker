#!/bin/bash
cp /docker/configs/apache/apache.conf /etc/apache2/sites-enabled/000-default.conf
source /etc/apache2/envvars
#tail -F /var/log/apache2/* &
#/usr/sbin/service apache2 start
exec apache2 -D FOREGROUND