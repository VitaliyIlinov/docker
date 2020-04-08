FROM ubuntu:18.04
MAINTAINER vitaliy ilinov <ilinov123@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

ARG PHP_VERSION=7.2

#install base packages
RUN apt-get update && apt-get install -y curl\
    nano \
    wget \
    make \
    autoconf \
    software-properties-common

# add php repo
RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php && apt-get update -y

# add php && apache2
RUN apt-get update && apt-get install -y \
    apache2\
    libapache2-mod-php${PHP_VERSION} \
    #nginx \
    #php${PHP_VERSION}-fpm \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-xdebug


RUN a2enmod rewrite \
    # console command: id
    # 1000 - is USER;
    # && creating file in MOUNT volume will be from current user
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data

COPY docker/ /docker/
COPY docker/php.ini  /etc/php/${PHP_VERSION}/apache2/conf.d/custom.ini
COPY docker/xdebug.ini /etc/php/${PHP_VERSION}/mods-available/xdebug.ini

#additional
RUN bash /docker/after-build.sh

WORKDIR /var/www/app/

# By default, simply start.
CMD /docker/entrypoint.d/entrypoint.sh
