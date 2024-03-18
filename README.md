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

## Born2BeRoot (Virtualization)

The Born2BerRoot project at 42 introduces us the world of **virtualization**. In that project, we were tasked to set up a virtual machine and leverage the virtualization technology to simulate a server environment within our local machines. Let's do a quick recap. What is virtualization?

Virtualization is the process of creating virtual instances of computing resources (hardware mostly), allowing multiple operating systems to run on a single physical machine simultaneously. Each VM runs its own operating system (OS) and applications. Normally, we would install a hypervisor (e.g. VMWare, VirtualBox) to manage and supervise our virtual machines. Through virtualization, we can make more efficient use of our computer's power, running different operating system or applications without needing seperate physical hardware for each one.

## Inception (Containerization)

Inception project is about **containerization**. It's related to virtualization, but not quite. In containerization, you create lightweight, portable *containers* that bootstrap or package applications and their dependencies. Containers share the same operating system kernel with the host system, but each containers are isolated from each other. In containerization, there's no need to create virtual instances of host machine's hardware resouces. Instead, it share the host system's kernel, resulting in faster startup times and better utilization of system resources.

Docker is the most popular containerization platform, and it's also the tool that we will be using to containerize our application in this project. There are also other popular containerization platform like Kubernetes, Docker Swarm and Podman.

> Kernel: The central component of an operating system. It acts as a bridge between software applications and the hardware of a computer. The kernel manages system resources, such as memory and CPU time, and facilitates communication between software and hardware management.

## Docker

### Docker Engine

Most of the time, when we talked about Docker, we are referring to its core component, the Docker Engine. It manages containers on your host machine.

### Docker Images

To run an application with Docker, you start by creating a container image. This image should contains everything your application needs to run: the code, libraries, configuration, and dependencies. You create this image using a Dockerfile, which is like a recipe that tells Docker how to build the image.

### Dockerfile

The Dockerfile contains a set of instructions for building an image. It tells Docker what to include in the environment and how to set it up. It will always start with a base image, for example `FROM ubuntu:latest`. The base image normally will be an operating system or some common tools. Everything else will be added as new layers above this base layer.

### Building Images

```shell
docker build -t my-image /path/to/Dockerfile
```

Once you have a Dockerfile, you can use the Docker CLI to build the image. Docker will takes the intructions in the Dockerfile and creates an image.

### Running containers

```shell
docker run my-image
```

To run your application, you start a container from the image you built. A contaienr is essentially an instance of an image running as a process on your system. When you start a container, Docker creates a lightweight, isolated environment for your application to run in. This environment includes its own filesystem, network, and storage (enough amount of an OS, not the entire OS).

### Container lifecycle

```shell
docker stop my-container
docker rm my-container
docker exec -it my-container bash
```

Once your contaienr is running, Docker manages its lifecycle. You can start, stop, restart, remove containers using the Docker CLI. You can also access the container environment using some commands.
