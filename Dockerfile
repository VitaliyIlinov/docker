FROM ubuntu:18.04
MAINTAINER vitaliy ilinov <ilinov123@gmail.com>

#See makefile
ARG PHP_VERSION
ARG WEB_SERVER
ENV PHP_VERSION=${PHP_VERSION} \
    WEB_SERVER=${WEB_SERVER} \
    DEBIAN_FRONTEND=noninteractive


#install base packages
RUN apt-get update && apt-get install -y curl\
    nano \
    wget \
    make \
    autoconf \
    software-properties-common

# add php repo
RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php && apt-get update -y

# add php
RUN apt-get update && apt-get install -y \
   # php${PHP_VERSION} \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-xdebug


# console command: id
# 1000 - is USER;
# && creating file in MOUNT volume will be from current user
RUN usermod -u 1000 www-data \
    && groupmod -g 1000 www-data

COPY docker/ /docker/
COPY docker/xdebug.ini /etc/php/${PHP_VERSION}/mods-available/xdebug.ini

WORKDIR /var/www/html/

#additional
RUN bash /docker/after-build.sh

# By default.conf, simply start.
CMD /docker/entrypoint.sh
