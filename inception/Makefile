NAME	=	inception
COMPOSE	=	srcs/docker-compose.yml
ENV		=	--env-file srcs/.env
DOCK	=	sudo docker compose -f ${COMPOSE} ${ENV} -p ${NAME}
DOCKER_START = sudo systemctl start docker

all:	 volumes update-hosts build start

volumes:
		@mkdir -p /home/aschaefe/data/wordpress
		@mkdir -p /home/aschaefe/data/mariadb
		@sudo chmod -R 777 /home/aschaefe/data/wordpress
		@sudo chmod -R 777 /home/aschaefe/data/mariadb

build:
		${DOCK} build --no-cache

start:
		${DOCK} up -d

stop:
		${DOCK} down

clean:
		${DOCK} down --volumes --rmi all

fclean: clean
		sudo docker image prune --all
		sudo docker system prune -a --volumes --force
		rm -rf ../data/mariadb
		rm -rf ../data/wordpress

# grabs the WP_URL value from the .env file.
# strips the protocol (http:// or https://) from the URL to get the domain.
# adds an entry to the /etc/hosts file. This line assumes that the user running the Makefile has sudo privileges and can modify the /etc/hosts file.
update-hosts:
	$(eval WP_URL=$(shell grep -oP 'WP_URL=\K.*' srcs/.env))
	$(eval DOMAIN=$(shell echo $(WP_URL) | sed 's|https\?://||'))
	@if ! grep -q "$(DOMAIN)" /etc/hosts; then \
		echo "127.0.0.1 $(DOMAIN)" | sudo tee -a /etc/hosts > /dev/null; \
		echo "Added $(DOMAIN) to /etc/hosts"; \
	else \
		echo "$(DOMAIN) already exists in /etc/hosts"; \
	fi

re:		fclean all

.PHONY:	all build start clean vclean aclean re
