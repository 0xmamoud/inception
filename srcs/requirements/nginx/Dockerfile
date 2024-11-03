FROM debian:11
RUN apt update && apt upgrade -y
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/mkane.crt -keyout /etc/nginx/ssl/mkane.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mkane.42.fr/UID=mkane"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
CMD ["nginx", "-g", "daemon off;"]

