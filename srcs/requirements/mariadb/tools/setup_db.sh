#!/bin/bash

# create a directory that is typically used for storing the MySQL/MariaDB daemon (server) socket file.
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize the database if not already done
# this directory is part of the default MySQL/MariaDB data directory.
# it contains system tables and files that store metadata about databases
# and other global settings.
if [ ! -d "/var/lib/mysql/${WP_DB_NAME}" ]; then

    chown -R mysql:mysql /var/lib/mysql

    # Initialize database
    # --basedir specifies the base directory where the MySQL distribution is installed
    # --datadir specifies the location of the data directory
    # redirect to /dev/null to discard any diagnostic messages produced by the command
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql > /dev/null

    # mysqld - MySQL/MariaDB server daemon
    # 1. change mariadb root user password
    # 2. create a db user account
    # 3. create wordpress database
    # 4. give the specified user full control on the wordpress database
    mysqld --user=mysql --bootstrap <<< "
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';
    CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME};
    CREATE USER IF NOT EXISTS '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASS}';
    GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'%';
    FLUSH PRIVILEGES;
    "

fi

exec "$@"
