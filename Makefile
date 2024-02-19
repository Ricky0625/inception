# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wricky-t <wricky-t@student.42kl.edu.my>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/19 15:30:33 by wricky-t          #+#    #+#              #
#    Updated: 2024/02/19 23:23:09 by wricky-t         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			:= inception
COMPOSE_FILE	:= ./srcs/docker-compose.yml

help:
	@echo "Usage: make <option>"
	@echo "<option>"
	@echo "  build   : Build the Docker images"
	@echo "  up      : Start the Docker containers"
	@echo "  down    : Stop and remove the Docker containers"
	@echo "  clean   : Stop and remove the Docker images and containers"
	@echo "  fclean  : Stop and remove the Docker images, containers, and volumes"
	@echo "  restart : Restart the Docker containers"

build:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) build

up:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) up -d

down:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down

clean:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down --rmi

fclean:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down --volumes --rmi all

restart: down up

.PHONY: help build up down clean fclean restart
