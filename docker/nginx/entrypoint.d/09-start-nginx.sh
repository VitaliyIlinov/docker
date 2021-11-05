#!/bin/bash
/usr/sbin/service php8.0-fpm start
/usr/sbin/service nginx start
tail -f /var/log/nginx/error.log
