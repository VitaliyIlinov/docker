#!/bin/bash
apt-get update && apt-get -y install nginx php${PHP_VERSION}-fpm
cp /docker/nginx/default.conf /etc/nginx/sites-enabled/default

#dont forget change to default.conf socket
cp /docker/php.ini /etc/php/${PHP_VERSION}/fpm/conf.d/custom.ini