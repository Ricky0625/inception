FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

COPY ./config/static.conf /etc/nginx/sites-available/default
COPY ./config/index.html /var/www/html

EXPOSE 4242

CMD ["nginx", "-g", "daemon off;"]
