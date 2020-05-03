FROM node:14.1.0 AS production-pseudo

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash \
      make \
      curl \
      locales \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

COPY . /web/xxx-blog/front
WORKDIR /web/xxx-blog/front

COPY docker-entrypoint.sh /usr/local/sbin/
ENTRYPOINT ["docker-entrypoint.sh"]

# --

FROM production-pseudo AS development