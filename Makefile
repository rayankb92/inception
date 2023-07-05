all:
	bash -c "docker compose up -d"
clean:
	bash -c "cd srcs; docker compose down"
networks:
	bash -c "docker network ls"
volumes:
	bash -c "docker volume ls"
fclean: clean
	bash -c "docker image prune --force; docker image rm nginx:v1 wordpress:v1 mariadb:v1"

del_volumes:
	bash -c "docker volume rm inception_mariadb_data inception_wordpress_data"
images:
	bash -c "docker images"
logs:
	bash -c "docker compose logs"
