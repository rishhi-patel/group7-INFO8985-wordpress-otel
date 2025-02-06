FROM php:8.3.6-cli-alpine3.19

RUN apk update \
    && apk add curl \
# install the PHP extensions we need
    && apk add wget mysql mysql-client php82-mysqli
RUN docker-php-ext-install mysqli

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/bin/wp-cli && chmod +x /usr/bin/wp-cli

USER www-data:www-data
WORKDIR /var/local/wordpress

RUN wp-cli core download

RUN mv wp-content wp-content.bak
RUN mkdir /var/local/wordpress/wp-content
RUN chown www-data:www-data /var/local/wordpress/wp-content
VOLUME /var/local/wordpress/wp-content
COPY ./wp-config.php wp-config.php
COPY ./phpinfo.php phpinfo.php
COPY ./start_wordpress.sh start_wordpress.sh

CMD sh start_wordpress.sh