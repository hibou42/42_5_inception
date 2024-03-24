FROM debian:stable-slim

# the first directory is in case nginx needs it, as it might be used by it to manage its main process. 
# the second directory is to store informations relative to the ssl certificates and keys. It is not the standard directory but it is fine to use a custom directory for organ purposes.

RUN apt update -y
RUN apt install nginx openssl vim curl -y

RUN mkdir -p /var/run/nginx
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=aschaefe.42.fr/UID=login"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
