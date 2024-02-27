# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wricky-t <wricky-t@student.42kl.edu.my>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/19 15:30:33 by wricky-t          #+#    #+#              #
#    Updated: 2024/02/27 16:40:44 by wricky-t         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				:= inception
COMPOSE_FILE		:= ./srcs/docker-compose.yml
SSL_SETUP_SCRIPT	:= ./srcs/requirements/tools/ssl_setup.sh
DATA_SETUP_SCRIPT	:= ./srcs/requirements/tools/data_setup.sh
CLEANUP_SCRIPT		:= ./srcs/requirements/tools/cleanup.sh

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
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down --rmi

fclean:
	docker compose -f $(COMPOSE_FILE) -p $(NAME) down --volumes --rmi all
	@chmod +x $(CLEANUP_SCRIPT)
	sudo chown -R $(USER):$(USER) ~/data/html
	@$(CLEANUP_SCRIPT)

restart: down up

rebuild: fclean up

setup:
	@chmod +x $(DATA_SETUP_SCRIPT) $(SSL_SETUP_SCRIPT)
	@$(DATA_SETUP_SCRIPT)
	@$(SSL_SETUP_SCRIPT)

.PHONY: help build up down clean fclean restart
