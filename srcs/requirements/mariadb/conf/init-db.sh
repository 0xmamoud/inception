#!/bin/bash
echo "Starting init-db.sh script..."

# Afficher les variables d'environnement pour le débogage
echo "$SQL_ROOT_PASSWORD ROOT PASSWORD"
echo "$SQL_DATABASE DATABASE"
echo "$SQL_USER USER"
echo "$SQL_PASSWORD PASSWORD"

# Démarrer le service MariaDB
service mariadb start
# Attendre que le serveur MariaDB soit pleinement opérationnel
until mysqladmin ping --silent; do
    sleep 2
done
echo "MariaDB service started."

# Créer la base de données
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
echo "Database created."

# Créer l'utilisateur
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "User created."

# Attribuer les privilèges à l'utilisateur
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "Privileges granted."

# Mettre à jour le mot de passe root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" || echo "Root password not updated."
echo "Root password updated."

# Rafraîchir les privilèges
mysql -e "FLUSH PRIVILEGES;" || echo "Privileges not flushed."
echo "Privileges flushed."

# Arrêter le serveur MySQL de façon contrôlée avec le mot de passe root
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown || echo "MySQL server not shut down."
echo "MySQL server shutting down."

# Lancer le serveur MySQL en mode sûr
exec mysqld_safe

