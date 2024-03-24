FROM debian:buster

# Install dependencies, PHP, and extensions required by WordPress
RUN apt-get update && apt-get upgrade -y \
    && apt-get -y install wget php7.3 php7.3-fpm php-mysql mariadb-client netcat

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
    && tar -xzf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www \
    && rm /var/www/wordpress-6.0-fr_FR.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY conf/script.sh /
COPY conf/wp-config.php /var/www/wordpress/wp-config.php
COPY conf/theme /var/www/wordpress/wp-content/themes/theme

RUN chown -R www-data:www-data /var/www/wordpress \
    && find /var/www/wordpress -type d -exec chmod 755 {} \; \
    && find /var/www/wordpress -type f -exec chmod 644 {} \; \
    && chmod 777 /etc/php/7.3/fpm/pool.d/www.conf

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["bash", "/script.sh"]
