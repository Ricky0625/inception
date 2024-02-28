# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wricky-t <wricky-t@student.42kl.edu.my>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/19 15:30:33 by wricky-t          #+#    #+#              #
#    Updated: 2024/02/28 10:21:31 by wricky-t         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				:= inception
COMPOSE_FILE		:= ./srcs/docker-compose.yml
SSL_SETUP_SCRIPT	:= ./srcs/requirements/tools/ssl_setup.sh
CLEANUP_SCRIPT		:= ./srcs/requirements/tools/cleanup.sh
DATA_FOLDER			:= /home/ricky/data

help:
	@echo "Usage: make <option>"
	@echo "<option>"
	@echo "  build   : Build the Docker images"
	@echo "  up      : Start the Docker containers"
	@echo "  down    : Stop and remove the Docker containers"
	@echo "  clean   : Stop and remove the Docker images and containers"
	@echo "  fclean  : Stop and remove the Docker images, containers, and volumes"
	@echo "  restart : Restart the Docker containers"
	@echo "  rebuild : fclean & up"
	@echo "  setup   : Run the scripts to generate ssl and the data folder"

build: setup
	docker compose -f $(COMPOSE_FILE) -p $(NAME) build

up: setup
	docker compose -f $(COMPOSE_FILE) -p $(NAME) up -d

down:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down

clean:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down --rmi all

fclean:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down --volumes --rmi all
	sudo rm -rf $(DATA_FOLDER)/ssl/* $(DATA_FOLDER)/html/* $(DATA_FOLDER)/db/*

restart: down up

rebuild: clean up

setup:
	@chmod +x $(SSL_SETUP_SCRIPT)
	@$(SSL_SETUP_SCRIPT)

.PHONY: help build up down clean fclean restart
