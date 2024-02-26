FROM debian:bullseye

# install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# copy config file into image
COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled

# testing
EXPOSE 443

# start NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]