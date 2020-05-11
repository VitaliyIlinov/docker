#!/bin/bash
cp /docker/nginx/default.conf /etc/nginx/sites-enabled/default
cp /docker/php.ini /etc/php/${PHP_VERSION}/fpm/conf.d/custom.ini
/usr/sbin/service php7.2-fpm start
/usr/sbin/service nginx start
tail -f /dev/null
