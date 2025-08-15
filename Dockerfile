FROM php:8.3.6-cli-alpine3.19

# Install build dependencies first
RUN apk update \
    && apk add --no-cache \
        gcc \
        g++ \
        make \
        autoconf \
        linux-headers \
        curl \
        wget \
        mysql \
        mysql-client \
        php82-mysqli \
        php82-pear \
        php82-dev \
        pkgconfig

# Install OpenTelemetry extension
RUN pecl install opentelemetry

# Install the PHP extensions we need
RUN docker-php-ext-install mysqli

# Download and setup WordPress
RUN curl https://wordpress.org/latest.zip -o /tmp/wordpress.zip
RUN unzip -d /var/local /tmp/wordpress.zip && chown -R www-data:www-data /var/local/wordpress

USER www-data:www-data
WORKDIR /var/local/wordpress

RUN mv wp-content wp-content.bak
RUN mkdir /var/local/wordpress/wp-content
RUN chown www-data:www-data /var/local/wordpress/wp-content
VOLUME /var/local/wordpress/wp-content

COPY ./wp-config.php wp-config.php
COPY ./phpinfo.php phpinfo.php
COPY ./start_wordpress.sh start_wordpress.sh
COPY ./otel.php.ini /usr/local/etc/php/conf.d/otel.ini

CMD sh start_wordpress.sh