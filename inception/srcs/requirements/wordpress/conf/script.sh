#!/bin/bash

echo "Checking MariaDB readiness..."
until nc -z -w30 mariadb 3306
do
  echo 'Waiting for MariaDB...'
  sleep 3
done
echo "Success: MariaDB is up and running"

echo "Setting up WordPress..."
mkdir -p /run/php
cd /var/www/wordpress/

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
  echo "Installing WordPress core..."
  wp core install --allow-root \
    --url="${WP_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_NAME}" \
    --admin_password="${WP_ADMIN_PWD}" \
    --admin_email="${WP_ADMIN_EMAIL}"
else
  echo "WordPress is already installed."
fi

# Check if the user already exists
if ! wp user get "${WP_USER_NAME}" --field=login --allow-root > /dev/null 2>&1; then
  echo "Creating WordPress user..."
  wp user create "${WP_USER_NAME}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PWD}" --allow-root
else
  echo "The '${WP_USER_NAME}' username is already registered."
fi

# Activate custom theme using WP-CLI
echo "Applying theme..."
wp theme activate theme --allow-root

echo "Starting PHP-FPM..."
/usr/sbin/php-fpm7.3 --nodaemonize
# running in the foreground. Daemon = background
