#!/bin/sh

cd ${WORDPRESS_PATH_DIRECTORY}

if [ ! -f wp-config.php ]; then
wp config create --allow-root --dbname=${MARIADB_DB_NAME} \
				 --dbuser=${MARIADB_ADMIN_USERNAME} \
				 --dbpass=${MARIADB_ADMIN_PASSWORD} \
				 --dbhost=mariadb:3306;

wp core install --url=${WORDPRESS_HTTPS_URL} \
				--title=${WORDPRESS_SITE_TITLE} \
				--admin_user=${WORDPRESS_ADMIN_USERNAME} \
				--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
				--admin_email=${WORDPRESS_ADMIN_EMAIL};

wp user create	${WORDPRESS_BASE_USER_USERNAME} \
				${WORDPRESS_BASE_USER_EMAIL} \
				--user_pass=${WORDPRESS_BASE_USER_PASSWORD} \
				--role=author;


wp config set WP_CACHE "true" --raw
wp config set WP_REDIS_HOST "redis"
wp plugin install redis-cache --activate
wp redis enable
wp option update permalink_structure '/%postname%/';


fi

exec php-fpm81 -F;