all: up

up: build
	
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

build:
	clear
	docker-compose -f ./srcs/docker-compose.yml build

clean: down
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f

.PHONY: all up down build clean re prune
