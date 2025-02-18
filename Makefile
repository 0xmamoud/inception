# Colors for pretty printing
GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

# Variables
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = ${HOME}/data
VOLUME_WP = $(DATA_PATH)/wordpress
VOLUME_DB = $(DATA_PATH)/mariadb

# Main commands
all: setup build up

# Setup directories and hosts
setup:
	@printf "$(GREEN)Setting up project...$(RESET)\n"
	@mkdir -p $(VOLUME_WP) 
	@mkdir -p $(VOLUME_DB) 
	@if ! grep -q "mkane.42.fr" /etc/hosts; then \
		sudo sh -c 'echo "127.0.0.1 mkane.42.fr" >> /etc/hosts'; \
	fi

# Build containers
build:
	@printf "$(GREEN)Building containers...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) build --no-cache

# Start services
up:
	@printf "$(GREEN)Starting services...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d

# Stop services
down:
	@printf "$(RED)Stopping services...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) down

# Clean everything
clean: down
	@printf "$(RED)Cleaning up containers and images...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) down --rmi all
	@docker system prune -af

# Full cleanup including volumes
fclean: clean
	@printf "$(RED)Full cleanup including volumes...$(RESET)\n"
	@docker volume prune -f
	@docker volume rm mariadb
	@docker volume rm wordpress
	@rm -rf $(VOLUME_WP)
	@rm -rf $(VOLUME_DB)

# Restart services
re: fclean all

# Show container status
status:
	@docker compose -f $(DOCKER_COMPOSE_FILE) ps
	@docker ps

# Show logs
logs:
	@docker compose -f $(DOCKER_COMPOSE_FILE) logs

.PHONY: all setup build up down clean fclean re status logs
