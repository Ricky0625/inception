FROM debian:bullseye

# install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# testing
EXPOSE 80

# start NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]