# Inception

One container is not enough. We need to go deeper.

This project aims to broaden our knowledge of system administration by using Docker. We will need to virtualize several Docker images, creating a network of containers as well as a container able to monitor it all.

## Table of Contents

- [Inception](#inception)
  - [Table of Contents](#table-of-contents)
  - [Project structure](#project-structure)
  - [Things to set up (Mandatory)](#things-to-set-up-mandatory)
  - [Things to set up (Bonus)](#things-to-set-up-bonus)

## Project structure

```bash
root
 |--- srcs (where all the configuration files are)
 Makefile 
```

The whole project has to be done in a virtual machine. Each Docker image must have the same name as its corresponding service. Each service has to run in a dedicated container.

For performance matters, the containers must be built either from the penultimate stable version of Alpine, or from Debian.

Each of the service should has its own Dockerfile. The Dockerfile must be called in your `docker-compose.yml` file by my Makefile.

## Things to set up (Mandatory)

- [ ] A docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
- [ ] A docker container that contains Wordpress + php-fpm (must be installed and configured) only without nginx.
- [ ] A docker container that contains MariaDB only without nginx.
- [ ] A volume that contains your Wordpress database.
- [ ] A second volume that contains your Wordpress website files.
- [ ] A docker-network that establishes the connection between your containers.
- [ ] In WordPress database, there must be two users, one of them being the administrator. The administrator's username can't contain admin/Admin or administrator/Administrator.

## Things to set up (Bonus)

- `redis cache` for WordPress website in order to properly manage the cache.
- `FTP server` container pointing to the volumn of your WordPress website.
- A simple static website in the language of your choice except PHP.
- Set up `Adminer`
- Set up a service of your choice that you think is useful. (eg: Grafana, Prometheus, etc.)

## Docker

### Docker Commands

```shell
# list all the running containers
docker ps

# list all the images
docker images

# build images
docker build -t app:1.0 .
# docker build <option> <app name> <where is the dockerfile>
# -t is to name it

# create a running process, called a container
docker run b909406d737c
# docker run <image id>

# with port-forwarding:
docker run -p 5000:8080 b909406d737c
# port- local:container

# create a volume
docker volume create shared-stuff

# mount volume
docker run --mount source=shared_stuff,target=/stuff
```

### Dockerfile

Every instruction in the Dockerfile is consider as a Layer. To keep things efficient, docker will cache layers if nothing is actually changed.

```Dockerfile
# The first instruction in our Dockerfile (must be)
# Set the base image to use in the subsequent instructions
FROM baseImage

# It's like cd into a directory and the subsequent instructions will start from this directory
WORKDIR /app

# Copy files or folders from source to the dest path in the image's filesystem
COPY source dest
COPY hello.txt /absolute/path
COPY hello.txt relative/to/workdir

# it's like opening a terminal session and run commands
RUN npm install

# copy source code (demo only)
# but what if we want to ignore some folders/files?
# we can do that by creating a .dockerignore (just like a gitignore file)
COPY . .

# set environment variable
ENV PORT=8080

# expose port
EXPOSE 8080

# the final instruction, CMD
# tells the container how to run the actual application
# unlike RUN, which is in a SHELL FORM, CMD is in EXEC FORM
CMD ["npm", "start"]
```

### Docker Compose

A tool for running multiple docker containers at the same time.

```yml
version: '3'
services:
  web:
    build: .
    ports:
      - "8080:8080"
  db:
    image: "mysql"
    environment:
      MYSQL_ROOT_PASSWORD: password
    volumes:
     - db-data:/foo
```

Run docker compose:

```shell
docker-compose up
```
