#!/bin/bash

sleep 10

cd /var/www/wordpress

# Vérifier si wp-config.php existe déjà
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  # Créer le fichier wp-config.php
  wp config create --allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'

  # Installer WordPress
  wp core install --allow-root \
                  --url=https://${SERVER_NAME} \
                  --title=${WP_SITE_TITLE} \
                  --admin_user=${WP_ADMIN_USER} \
                  --admin_password=${WP_ADMIN_PASSWORD} \
                  --admin_email=${WP_ADMIN_EMAIL}

  # Créer un utilisateur WordPress
  wp user create ${WP_USER} ${WP_USER_EMAIL} \
                 --role=author \
                 --user_pass=${WP_USER_PASSWORD} \
                 --allow-root
else
  echo "WordPress is already installed. Skipping installation."
fi

echo "WordPress configuration completed."

# Lancer PHP-FPM
exec php-fpm7.4 -F -R

