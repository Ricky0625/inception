# Inception - Eh yoooo

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
