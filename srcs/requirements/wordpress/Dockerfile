FROM debian:bullseye

# install some php packages and wp-cli
RUN apt-get update \
    && apt-get install -y \
        php7.4 \
        php7.4-fpm \
        php7.4-mysqli \
        php7.4-gd \
        php7.4-xml \
        curl \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/install_wp.sh /scripts/
RUN chmod +x /scripts/install_wp.sh

WORKDIR /var/www/html

ENTRYPOINT ["/scripts/install_wp.sh"]

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
