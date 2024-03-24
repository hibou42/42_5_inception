# srcs Directory

This directory contains the source files and configurations necessary for the Docker-based project infrastructure.

- `docker-compose.yml`: Orchestration file for Docker containers, specifying how they are built, run, and interconnected.
- `.env`: Environment variable file storing sensitive configurations such as database passwords and user names.

Run docker-compose up -d mariadb to start only the MariaDB service defined in your docker-compose.yml. This command builds the MariaDB container based on your custom Dockerfile and starts it with the specified volume for data persistence.

### Build the image.
sudo docker build -t mariadb .

### Run nginx with an argument (-v) in this case, an html file, when the container is not linked to WordPress
docker run -d -p 443:443 --name my-nginx -v /path/to/myproject/html:/usr/share/nginx/html my-nginx

### Delete (force) container
sudo docker rm -f 'nom du container'

### Stop container/image ?
sudo docker stop mariadb

### Rename image
sudo docker rename mariadb mariadb_old

### List running containers/images ? Still a wee bit confusing...
sudo docker ps 

### Execute mariadb
sudo docker exec -it my-mariadb mysql -uroot -p

### Complete command (delete container > delete image > build image > run container)
sudo docker rm -f my-mariadb && sudo docker rmi mariadb -f && sudo docker build -t mariadb . && sudo docker run -d -p 3306:3306 --name my-mariadb mariadb

### Volumes
# Complete command using volumes
sudo docker rm -f my-mariadb && sudo docker rmi mariadb -f && sudo docker build -t mariadb . && sudo docker run -d -p 3306:3306 --name my-mariadb -v mariadb_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mariadb

docker volume create mariadb_data > this will create the volume, but it is not needed, because docker will create it if it does not exist when running the container.

run MariaDB container using the docker run command and attach the volume created (or want Docker to create) to the container. Need to specify the volume mount option (-v or --mount) to attach the volume to the container's data directory (/var/lib/mysql for MariaDB).

# Using -v (simpler syntax):
docker run -d \
  -p 3306:3306 \
  --name my-mariadb \
  -v mariadb_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  mariadb

# Or using --mount (more verbose syntax):
docker run -d \
  -p 3306:3306 \
  --name my-mariadb \
  --mount source=mariadb_data,target=/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  mariadb

In these commands:
-d runs the container in detached mode.
-p 3306:3306 maps port 3306 on the host to port 3306 in the container, allowing you to connect to the MariaDB server.
--name my-mariadb assigns a name to your container for easy reference.
-v mariadb_data:/var/lib/mysql or --mount source=mariadb_data,target=/var/lib/mysql mounts the mariadb_data volume to /var/lib/mysql in the container, ensuring data persistence.
-e MYSQL_ROOT_PASSWORD=my-secret-pw sets the MariaDB root password to my-secret-pw. Change this to a secure password of your choice.


### Run vs CMD in dockerfiles
CMD: This Dockerfile instruction provides the default execution command for the container. Unlike RUN commands, which execute at build time to form the layers of the Docker image, the CMD command is executed when a container is started from the final image.




- Ensure that NGINX can be accessed by port 443 only. Once done, open the page.
- Ensure that a SSL/TLS certificate is used.
- Ensure that the WordPress website is properly installed and configured (you shouldn't see the WordPress Installation page). To access it, open href=https://login.42.fr in your browser, where login is the login of the evaluated student. You shouldn't be able to access the site via http://login.42.fr.
- Start by checking the Dockerfiles. There must be one Dockerfile per service. Ensure that the Dockerfiles are not empty files. If it's not the case or if a Dockerfile is missing, the evaluation process ends now.
- Make sure the evaluated student has written their own Dockerfiles and built their own Docker images. Indeed, it is forbidden to use ready-made ones or to use services such as DockerHub.
- Ensure that every container is built from the penultimate stable version of Alpine/Debian. If a Dockerfile does not start with 'FROM alpine:X.X.X' or 'FROM debian:XXXXX', or any other local image, the evaluation process ends now.          
- The Docker images must have the same name as their corresponding service. Otherwise, the evaluation process ends now.
- Ensure that the Makefile has set up all the services via docker compose. This means that the containers must have been built using docker compose and that no crash happened. Otherwise, the evaluation process ends.
- Ensure that docker-network is used by checking the docker-compose.yml file. Then run the 'docker network ls' command to verify that a network is visible.
- The evaluated student has to give you a simple explanation of docker-network. If any of the above points is not correct, the evaluation process ends now.


NGINX with SSL/TLS
- Ensure that there is a Dockerfile.
- Using the 'docker compose ps' command, ensure that the container was created (using the flag '-p' is authorized if necessary).
- Try to access the service via http (port 80) and verify that you cannot connect.
- Open https://login.42.fr/ in your browser, where login is the login of the evaluated student. The displayed page must be the configured WordPress website (you shouldn't see the WordPress Installation page).
- The use of a TLS v1.2/v1.3 certificate is mandatory and must be demonstrated. The SSL/TLS certificate doesn't have to be recognized. A self-signed certificate warning may appear. If any of the above points is not clearly explained and correct, the evaluation process ends now.


WordPress with php-fpm and its volume
- Ensure that there is a Dockerfile.
- Ensure that there is no NGINX in the Dockerfile.
- Using the 'docker compose ps' command, ensure that the container was created (using the flag '-p' is authorized if necessary).
- Ensure that there is a Volume. To do so: Run the command 'docker volume ls' then 'docker volume inspect &lt;volume name&gt;'. Verify that the result in the standard output contains the path '/home/login/data/', where login is the login of the evaluated student.
- Ensure that you can add a comment using the available WordPress user.
- Sign in with the administrator account to access the Administration dashboard. The Admin username must not include 'admin' or 'Admin' (e.g., admin, administrator, Admin-login, admin-123, and so forth).
- From the Administration dashboard, edit a page. Verify on the website that the page has been updated. If any of the above points is not correct, the evaluation process ends now.


MariaDB and its volume
- Ensure that there is a Dockerfile.
- Ensure that there is no NGINX in the Dockerfile.
- Using the 'docker compose ps' command, ensure that the container was created (using the flag '-p' is authorized if necessary).
- Ensure that there is a Volume. To do so: Run the command 'docker volume ls' then 'docker volume inspect &lt;volume name&gt;'. Verify that the result in the standard output contains the path '/home/login/data/', where login is the login of the evaluated student.
- The evaluated student must be able to explain you how to login into the database. Verify that the database is not empty. If any of the above points is not correct, the evaluation process ends now.

Persistence!
- This part is pretty straightforward. You have to reboot the virtual machine. Once it has restarted, launch docker compose again. Then, verify that everything is functional, and that both WordPress and MariaDB are configured. The changes you made previously to the WordPress website should still be here. If any of the above points is not correct, the evaluation process ends now.

