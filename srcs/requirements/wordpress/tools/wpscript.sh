#!/bin/sh

cd ${WORDPRESS_PATH_DIRECTORY}

if [ ! -f wp-config.php ]; then
wp config create --allow-root \
				 --dbname=${SQL_DATABASE} \
				 --dbuser=${SQL_USER} \
				 --dbpass=${SQL_ROOT_PASSWORD} \
				 --dbhost=mariadb:3306;

wp core install --allow-root \
				--url=${DOMAIN_NAME} \
				--title=${SITE_TITLE} \
				--admin_user=${ADMIN_USER} \
				--admin_password=${ADMIN_PASSWORD} \
				--admin_email=${ADMIN_EMAIL};

wp user create	--allow-root \
				${USER1_LOGIN} ${USER1_MAIL} \
				--user_pass=${USER1_PASS} \
				--role=author;

wp cache flush --allow-root;

wp option update permalink_structure '/%postname%/';

fi

exec php-fpm7.3 -F;