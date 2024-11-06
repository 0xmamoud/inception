#!/bin/bash

sleep 10

cd /var/www

wp config create	--allow-root \
							--dbname=$SQL_DATABASE \
							--dbuser=$SQL_USER \
							--dbpass=$SQL_PASSWORD \
							--dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install	--allow-root \
		    	--url=https://${SERVER_NAME} \
		    	--title=${WP_SITE_TITLE} \
		    	--admin_user=${WP_ADMIN_USER} \
			    --admin_password=${WP_ADMIN_PASSWORD} \
		    	--admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root \
		      ${WP_USER} ${WP_USER_EMAIL} \
			    --role=author \
			    --user_pass=${WP_USER_PASSWORD} 
fi

if [ ! -f /run/php/php7.4-fpm.sock ]; then
  mkdir -p /run/php
fi

exec php-fpm7.4 -F -R
