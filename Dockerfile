FROM php:8.3.6-cli-alpine3.19

# Build & runtime deps (PECL, tools, DB client)
RUN apk add --no-cache $PHPIZE_DEPS curl wget unzip bash mariadb-client

# OpenTelemetry extension (PECL) + enable
RUN pecl install opentelemetry && docker-php-ext-enable opentelemetry

# Common PHP extensions for WP
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Fetch & stage WordPress
RUN curl -fsSL https://wordpress.org/latest.zip -o /tmp/wordpress.zip \
    && unzip -q /tmp/wordpress.zip -d /var/local \
    && mkdir -p /var/local/wordpress/wp-content \
    && chown -R www-data:www-data /var/local/wordpress

# App files
COPY --chown=www-data:www-data ./wp-config.php /var/local/wordpress/wp-config.php
COPY --chown=www-data:www-data ./phpinfo.php   /var/local/wordpress/phpinfo.php
COPY --chown=www-data:www-data ./start_wordpress.sh /usr/local/bin/start_wordpress.sh
COPY ./otel.php.ini /usr/local/etc/php/conf.d/otel.ini

# Allow script execution
USER root
RUN chmod +x /usr/local/bin/start_wordpress.sh
USER www-data

WORKDIR /var/local/wordpress
VOLUME ["/var/local/wordpress/wp-content"]

EXPOSE 8080
CMD ["/usr/local/bin/start_wordpress.sh"]
