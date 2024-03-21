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

Once your container is running, Docker manages its lifecycle. You can start, stop, restart, remove containers using the Docker CLI. You can also access the container environment using some commands.

## Docker Compose

Docker compose is a tool that makes running multiple Docker container easier. This is by describing everything in a declarative config file (.yml file) and using command like `docker compose up` to bring your whole application to life, with all the containers, networks, and settings set up just the way you want them. This is extremely helpful if you want to deploy an infrastructure with multiple microservices. You don't have to type all the long docker commands to run all your containers, just a few simple set of commands will do.

## Docker vs VM

- Containers and VMs both need a host, whether it's a laptop, a bare metal server in your data center or and instance in the public cloud to run.
- VM needs to run on a hypervisor. Hypervisor claims the **physical resources** such as CPU, RAM, storage and network cards. It then create virtual constructs of those hardware resources that feel exactly like the real thing. Then it packages them into a software construct called a virtual machine.
- For containers, we need to install a container engine such as Docker. The container engine separates the **OS resources** (process tree, filesystem, network stack, etc.) and packages them into virtual operating systems called *containers*. Each container works just like a real OS.
- Hypervisors perform **hardware virtualization**, which makes physical hardware resources into virtual versions called VMs. For containers, it perform **OS virtualization**, which made OS resources into virtual versions called containers.
- VM has higher VM tax than containers. For VM, it needs to construct all those virtual versions of physical hardware. For container, it just share the host operating system's kernel, there's no need to create those virtual constructs.
- VM has higher OS tax because it requires a full OS installation. Running multiple VMs on a single host can result in duplicated OS components and increased resource usage. Container still incur some OS tax because it rely on the host operating system. However, this overhead is generally way lower compared to running multiple VMs with separate OS instances.
- Containers start faster than VMs because they only need to start the application, with the kernl already running. VMs have to boot up the operating system.

### VM Tax

VM tax refers to the overhead or extra resources required to run a virtual machine. When you create a VM, the VM consumes resources such as CPU, memoty, and storage, even when it's not actively doing anything. This overhead is often referred to as the VM tax because it represents the additional cost incurred by using virtualization. Besides that, some OS also need their own licenses, as well as people to maintain and update them. These are considered as part of the VM tax as well.

### OS Tax

OS tax refers to the overhead of running an operating system in general. Every OS requires resources to run, whether it's on physical hardware or within a virtual machine.

## Others

### SSL/TLS certificates

SSL/TLS certificates are digital documents used to secure and authenticate communication over the internet. It plays a crucial role in establishing secure and trustworthy communication channels over the internet by encypting data, authenticating the identity of servers, and ensuring the integrity of transmitted information.

The wordpress site will shows that the certificate is not safe and this is normal. This is because we are using a self-signed certificates. Normally, it should be issued by trusted 3rd-party certificate authorities.

### Mariadb login

```shell
# login as root after exec
mysql # should throw error

# login as root using password
mysql -p

#login as user using password
mysql -u <user> -p
```

## Docker network

Docker network is a feature of Docker that enables communication between Docker containers, allowing them to interact with other and with external networks. Docker provides various type of network configuration and one of them is bridge networks, which is used in this project.

With bridge network, Docker creates a virtual network interfaces (like a virtual cable) that connects all the containers on that network. All containers on the same bridge network can communicate with each other. Containers on a bridge network can also communicate with the host machine and external networks. Docker handles the routing and network configuration to make this possible.

Docker allows direct communication between containers using their names as hostnames. This simplifies the configuration and management of container communication, enabling seamless connectivity between containers within the same Docker network.

### Docker volumes

There are two main types of data: persistent and non-persistent.

Persistent data is data that you need to keep. Non-persistent is data that you don't need to keep. By default, all containers get a layer of writable non-persistent storage that lives and dies with the container, which is called local storage.

Docker volumes are storage units that containers use to store and share data. It exists outside of the container filesystem, making data persistent even if the container is stopped or removed. Common use cases including using it as database storage, to store configuration files, and shared application data.

### Services

- nginx: A web server that can handles HTTP requests and server web pages efficiently.
- wordpress: A content management system for creating websites and blogs.
- mariadb: a relational database management system
- redis: an in-memory data structure store used as a database and cache.
- adminer: a lightweight database management tool for mysql, postgresql, and other database
- cadvisor: a container monitoring tool that provides detailed information about resource usage and performance metrics.
- ftp: a standard network protocol used for transferring files between a client and a server.

#### Redis check cache

```shell
# retrieve all keys stored in the database
KEYS *

# retrieve the value associated with a specific key
GET key_name
```

#### How to use FTP

```shell
# connect
ftp ftp.example.com

# login
user username

# list directory
ls

# change directory
cd directory_name

# download a file
get filename

# upload a file
put filename

# delete a file
delete filename

# quit
quit
```