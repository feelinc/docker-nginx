FROM debian:jessie

MAINTAINER Sulaeman <me@sulaeman.com>

ENV NGINX_VERSION=1.11.11 \
    NGINX_USER=www-data \
    NGINX_SITECONF_DIR=/etc/nginx/sites-available \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_TEMP_DIR=/var/lib/nginx \
    NGINX_SETUP_DIR=/var/cache/nginx

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget perl libssl1.0.0 libxslt1.1 libgd3 libxpm4 libgeoip1 libav-tools \
 && apt-get purge -y --auto-remove \
 && rm -rf /var/lib/apt/lists/*

COPY setup/ ${NGINX_SETUP_DIR}/
RUN bash ${NGINX_SETUP_DIR}/install.sh

ADD nginx.conf /etc/nginx/

RUN usermod -u 1000 www-data

EXPOSE 80 443

CMD ["nginx"]
