FROM debian:11
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.4 php-fpm php-mysql mariadb-client curl
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
RUN wget https://fr.wordpress.org/wordpress-6.6-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.6-fr_FR.tar.gz && rm -rf wordpress-6.6-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /run/php
COPY conf/wp-config.sh /var/www/wordpress/
RUN chmod 755 /var/www/wordpress/wp-config.sh
EXPOSE 9000
ENTRYPOINT ["bash", "/var/www/wordpress/wp-config.sh"]
