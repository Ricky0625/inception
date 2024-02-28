#!/bin/bash

# should run this script in /var/www/html. this is where wp-config.php will be located.

# need this otherwise cannot run :)
mkdir -p /run/php/
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

WP_CONFIG="./wp-config.php"

if [ -e "$WP_CONFIG" ]; then
    exit 1
fi

# fetches necessary files for wordpress
wp core download --allow-root

# create a wp-config.php with the specified database details
wp config create --dbname="$WP_DB_NAME" \
    --dbuser="$WP_DB_USER" \
    --dbpass="$WP_DB_PASS" \
    --dbhost="$WP_DB_HOST" \
    --allow-root

# install wordpress and create admin account
wp core install --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

# create user account
wp user create "$WP_USER_USER" "$WP_USER_EMAIL" \
    --role=subscriber \
    --user_pass="$WP_USER_PASS" \
    --first_name="$WP_USER_FNAME" \
    --last_name="$WP_USER_LNAME" \
    --allow-root

# pass over to another command
exec "$@"
