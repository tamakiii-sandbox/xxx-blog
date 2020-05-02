# syntax = docker/dockerfile:experimental

FROM php:7.4.5-fpm AS production-pseudo

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      bash \
      make \
      curl \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

COPY ./docker/php-fpm/install.mk /tmp/install.mk
RUN make -f /tmp/install.mk install

COPY ./docker/php-fpm/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY . /web/xxx-blog
WORKDIR /web/xxx-blog

# --

FROM production-pseudo AS development

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      procps \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*