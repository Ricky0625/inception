FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y php7.4 php7.4-mysqli wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget -O index.php https://www.adminer.org/latest.php \
    && chown -R www-data:www-data .

EXPOSE 8085

CMD ["php", "-S", "[::]:8085", "-t", "/var/www/html"]
