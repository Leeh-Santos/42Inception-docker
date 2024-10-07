all: build

build:
	docker-compose -f srcs/docker-compose.yml up --build

stop:
	docker-compose -f srcs/docker-compose.yml stop

remove:
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes

#only if need full reset
prune:
	sudo rm -rf /home/learodri/data/mariadb/*
	sudo rm -rf /home/learodri/data/wordpress/*
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes
	docker system prune -a --volumes --force

re:

.PHONY: all up down build clean re prune
