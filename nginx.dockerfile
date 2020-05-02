FROM nginx:1.17.9 AS production-pseudo

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# --

FROM production-pseudo AS development