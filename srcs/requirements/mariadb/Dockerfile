FROM debian:11
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/
EXPOSE 3306
COPY /conf/init-db.sh .
RUN chmod 755 init-db.sh
ENTRYPOINT ["./init-db.sh"]

