FROM debian:11
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server 
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/
COPY /conf/init-db.sh .
RUN chmod 755 init-db.sh
EXPOSE 3306
ENTRYPOINT ["./init-db.sh"]

