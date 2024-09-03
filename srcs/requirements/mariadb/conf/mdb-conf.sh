#!/bin/bash
    
service mariadb start;
sleep 3;

mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO \`${MYSQL_USER}\`@'%';"
mysql -u root -e "FLUSH PRIVILEGES";

mysqladmin -u root password "$MYSQL_PASSWORD"
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
echo    "DATABASE CREATED!!"

exec mysqld_safe --bind-address=*
