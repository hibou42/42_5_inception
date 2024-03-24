# MariaDB Service Directory

This directory houses the Dockerfile and configuration for the MariaDB service.

- `Dockerfile`: Instructions for building the MariaDB Docker image.
- `conf/`: Directory for MariaDB configuration files.
- `.dockerignore`: Helps to exclude files from being added to the Docker image.

# General Commands
## Execute mariadb
sudo docker exec -it my-mariadb mysql -uroot -p
- You will be prompted to enter the root password.

## Database Operations
- Lists all databases on the MariaDB server.
SHOW DATABASES;

- Creates a new database named dbname.
CREATE DATABASE dbname;

- Selects dbname as the database to work with.
USE dbname;

- Deletes the database named dbname and all its tables.
DROP DATABASE dbname;

## Table Operations
- Lists all tables in the current database.
SHOW TABLES;

- Creates a new table named tablename with specified columns.
CREATE TABLE tablename (l
    id INT AUTO_INCREMENT PRIMARY KEY,
    column1 VARCHAR(255),
    column2 INT
);

- Deletes the table named tablename.
DROP TABLE tablename;

- Shows the structure of tablename, including column definitions.
DESCRIBE tablename;

## Data Manipulation
- Inserts a new row into tablename.
INSERT INTO tablename (column1, column2) VALUES ('value1', value2);
INSERT INTO posts (title, content) VALUES ('New Post', 'Test');

- Retrieves all data from tablename.
SELECT * FROM tablename;

- Updates rows in tablename based on a condition.
UPDATE tablename SET column1='newvalue' WHERE id=some_value;

- Deletes rows from tablename based on a condition.
DELETE FROM tablename WHERE id=some_value;

## User and Permissions
- Creates a new user with a password.
Create User: CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

- Grants all privileges on dbname to username.
GRANT ALL PRIVILEGES ON dbname.* TO 'username'@'localhost';

- Displays the privileges granted to username.
SHOW GRANTS FOR 'username'@'localhost';

- Revokes all privileges on dbname from username.
REVOKE ALL PRIVILEGES ON dbname.* FROM 'username'@'localhost';

- Deletes username.
DROP USER 'username'@'localhost';

## Exiting the Shell
- Exits the MariaDB command line interface.
EXIT; or \q


## conf file 
- [mysqld]: This indicates that the settings following this line apply to the MariaDB server daemon process (mysqld).

- datadir = /var/lib/mysql: Specifies the directory where MariaDB stores database files. This is the path to the data directory containing all the databases.

- socket = /run/mysqld/mysqld.sock: Specifies the Unix socket file used for local connections to the MariaDB server. The socket file allows for communication with the database without using the network stack, improving performance for local connections.

- bind_address=*: This setting specifies the network address to which the MariaDB server binds. Using * means the server will accept connections on all network interfaces. It allows remote machines to connect to the MariaDB server. If security is a concern, this should be set to a specific interface's IP address or 127.0.0.1 for localhost only.

- port = 3306: Specifies the TCP/IP port on which the MariaDB server listens for connections. Port 3306 is the default for MariaDB and MySQL.

- user = mysql: Specifies the Unix user that the MariaDB server process runs as. This is a security measure to ensure that MariaDB runs with the permissions of a specific user, which is typically mysql, a user with limited system permissions to minimize security risks.