FROM php:7.4.5-fpm AS production-pseudo

COPY ./docker/php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./docker/php-fpm/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY . /web/xxx-blog-media
WORKDIR /web/xxx-blog-media

# --

FROM production-pseudo AS development

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      procps \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*