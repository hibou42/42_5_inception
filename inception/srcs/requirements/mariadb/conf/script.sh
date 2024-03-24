#!/bin/bash

echo "Running initialization scripts..."
# Ensure MariaDB is not running here because we want to start it manually after initialization
mysql_install_db > /dev/null 2>&1

# Initialize the MariaDB data directory
mysqld_safe --skip-networking &

MYSQL_TMP_PID=$!

echo "Waiting for MariaDB to respond..."
while ! mysqladmin ping --silent; do
    echo "Waiting for..."
    sleep 1
done

echo "MariaDB started."

# Use envsubst to substitute environment variable values into the SQL script
envsubst < /docker-entrypoint-initdb.d/initdb.sql.template > /docker-entrypoint-initdb.d/initdb.sql

echo "Running initialization scripts..."
for script in /docker-entrypoint-initdb.d/*.sql; do
    echo "Executing script: $script"
    mysql -u root -p"${SQL_ROOT_PWD}" < "$script"
done

mysqladmin shutdown

echo "Starting mysqld_safe as the main process..."
exec mysqld_safe # mariadb as the main process
