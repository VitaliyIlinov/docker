FROM ubuntu:18.04
MAINTAINER vitaliy ilinov <ilinov123@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

COPY ./configs/entrypoint.sh /sbin/entrypoint.sh

RUN apt-get update && apt-get install -y \
    nano \
    composer \
    apache2\
    php7.2 \
    php7.2-fpm \
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-curl \
    php7.2-mysql \
    php7.2-gd \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-iconv \
    php7.2-xdebug


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
