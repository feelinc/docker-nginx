# docker-nginx
Dockerized NGINX.

## Build

    $ chmod +x ./build.sh
    $ ./build.sh

## Prepare
- A folder where all container configuration data stored, in example "**nginx-container**".
- "**nginx-container/conf.d**" folder to provide additionals configuration, in example the php-fpm.conf.
- "**nginx-container/ssl**" folder to provide SSL Certificates. In case some of your site hosts require it.
- "**nginx-container/sites**" folder to provide site hosts configuration files.

## Run

"**--volumes-from**" option below required, if some of the site hosts is going to use a PHP container in the same host.

    docker run --interactive --tty --name=nginx --memory=512m \
        --hostname=nginx \
        --volume=/path/to/nginx-container/logs:/var/log/nginx \
        --volume=/path/to/nginx-container/conf.d:/etc/nginx/conf.d \
        --volume=/path/to/nginx-container/ssl:/etc/nginx/ssl \
        --volume=/path/to/nginx-container/sites:/etc/nginx/sites-available \
        --volumes-from=php \
        --publish="80:80" \
        --publish="443:443" \
        --detach \
        nginx:1.11.11

## Environment Defaults
    NGINX_VERSION=1.11.11
    NGINX_USER=www-data
    NGINX_SITECONF_DIR=/etc/nginx/sites-available
    NGINX_LOG_DIR=/var/log/nginx
    NGINX_TEMP_DIR=/var/lib/nginx
    NGINX_SETUP_DIR=/var/cache/nginx