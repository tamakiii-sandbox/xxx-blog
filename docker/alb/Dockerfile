FROM nginx:1.17.9 AS development

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      make \
      openssl \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY install.mk /tmp
RUN make -f /tmp/install.mk install