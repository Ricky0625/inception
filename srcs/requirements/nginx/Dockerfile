FROM debian:bullseye

# install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# copy config file into image
COPY ./config/nginx.conf /etc/nginx/sites-available/default

# testing
EXPOSE 443

# start NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]