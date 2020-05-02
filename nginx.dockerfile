FROM nginx:1.17.9 AS production-pseudo

COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

COPY . /web/xxx-blog
WORKDIR /web/xxx-blog

# --

FROM production-pseudo AS development