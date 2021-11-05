FROM ubuntu:18.04
MAINTAINER vitaliy ilinov <ilinov123@gmail.com>

#See makefile
ARG GROUP_ID
ARG USER_ID
ARG WEB_SERVER
ARG PHP_VERSION

ENV DEBCONF_NONINTERACTIVE_SEEN=true \
    DEBIAN_FRONTEND=noninteractive


#install base packages
RUN apt-get update && apt-get install -y \
    build-essential \
    locales \
    nano \
    zip \
    unzip \
    autoconf \
    make \
    wget \
    curl \
    software-properties-common

# add php repo
RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php && apt-get update -y

# Create user
RUN useradd -m ${USER_ID} --uid=${GROUP_ID}

COPY ./ /docker
#additional
RUN bash /docker/after-build.sh

# By default.conf, simply start.
CMD /docker/entrypoint.sh
