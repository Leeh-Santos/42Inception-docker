#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

WP_DIR=/var/www/wordpress

cd $WP_DIR
chmod -R 755 $WP_DIR/
chown -R www-data:www-data $WP_DIR

wait_db() {
	nc -zv mariadb 3306 2> /dev/null
	return $?
}

while ! wait_db; do
	echo "[========Waiting DB========]";
	sleep 1
done

if [ -f ./wp-config.php ]
then
    echo "[========WordPress files already exist. Skipping installation========]"
else
    echo "[========WP INSTALLATION STARTED========]"
	find /var/www/wordpress/ -mindepth 1 -delete
    wp core download --allow-root
    wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root
	echo $(pwd)
fi

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F