FROM ubuntu:18.04
MAINTAINER vitaliy ilinov <ilinov123@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    PHP_VERSION=php7.2

COPY ./configs/entrypoint.sh /sbin/entrypoint.sh

RUN apt-get update && apt-get install -y \
    nano \
    composer \
    apache2\
    ${PHP_VERSION} \
    ${PHP_VERSION}-fpm \
    libapache2-mod-${PHP_VERSION} \
    ${PHP_VERSION}-cli \
    ${PHP_VERSION}-curl \
    ${PHP_VERSION}-mysql \
    ${PHP_VERSION}-gd \
    ${PHP_VERSION}-xml \
    ${PHP_VERSION}-mbstring \
    ${PHP_VERSION}-iconv \
    ${PHP_VERSION}-xdebug


RUN a2enmod rewrite \
    # 1000 - is USER id
    # && creating file in volume will be from current user
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && chmod 755 /sbin/entrypoint.sh

#/etc/init.d/apache2 restart
# service apache2 status


COPY ./configs/app.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./configs/php.ini  /etc/php/7.2/apache2/conf.d/custom.ini
COPY ./configs/xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

WORKDIR /var/www/app/

# By default, simply start apache and export apache env.
CMD ["/sbin/entrypoint.sh"]
