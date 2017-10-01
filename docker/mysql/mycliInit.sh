#!/bin/bash

source mycfg.inc

docker run -it \
    --link mydb:mysql \
    -e MYSQL_ROOT_PASSWORD=$PASS \
    -v $PWD/script.sql:/host/script.sql \
    --rm \
    mariadb \
    sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" -e "source /host/script.sql"'
