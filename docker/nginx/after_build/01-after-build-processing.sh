#!/bin/bash
apt-get update && apt-get install -y \
  nginx \
  php${PHP_VERSION}-fpm
