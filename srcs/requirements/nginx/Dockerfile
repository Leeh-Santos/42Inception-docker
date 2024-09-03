FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=42/CN=learodri.42.fr/"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# create the wordpress directory
RUN mkdir -p /var/www/wordpress

# changes the ownership of the /var/www/wordpress directory to (www-data), which is the default user and group for NGINX.
RUN chown -R www-data:www-data /var/www/wordpress

# sem o -g e deamon tava a dar merda -- shutdown
CMD ["nginx", "-g", "daemon off;"]