#!/bin/bash
apt-get update && apt-get install -y apache2 libapache2-mod-php${PHP_VERSION}

cp /docker/apache/apache.conf /etc/apache2/sites-enabled/000-default.conf
cp /docker/php.ini /etc/php/${PHP_VERSION}/apache2/conf.d/custom.ini

