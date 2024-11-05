FROM debian:11
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld
EXPOSE 3306
COPY /conf/init-db.sh .
RUN chmod 755 init-db.sh
ENTRYPOINT ["./init-db.sh"]

