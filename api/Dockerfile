# syntax = docker/dockerfile:experimental

FROM php:7.4.5-fpm AS production-pseudo

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash \
      make \
      curl \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

COPY ./docker/php-fpm/install.mk /tmp/install.mk
RUN make -f /tmp/install.mk install

RUN docker-php-ext-install \
      pdo_mysql

COPY ./docker/php-fpm/conf.d/production.ini /usr/local/etc/php/conf.d/php.ini
COPY ./docker/php-fpm/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY . /web/xxx-blog/api
WORKDIR /web/xxx-blog/api

# --

FROM production-pseudo AS development

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      procps \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./docker/php-fpm/conf.d/development.ini /usr/local/etc/php/conf.d/php.ini
