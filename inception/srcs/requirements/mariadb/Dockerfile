FROM debian:buster

# Install mariadb server
RUN apt-get update -y && \
	apt-get install curl mariadb-server procps gettext-base -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/script.sh /
COPY ./conf/initdb/*.sql.template /docker-entrypoint-initdb.d/

RUN chmod +x /script.sh
CMD ["bash", "script.sh"]

# Removed apt upgrade from the RUN command as it is not necessary and makes the image size bigger.