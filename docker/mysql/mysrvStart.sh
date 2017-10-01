#!/bin/bash

source mycfg.inc

docker run -d \
    -e MYSQL_ROOT_PASSWORD=$PASS \
    --name mydb \
    --hostname mydb \
    -v "$D:/var/lib/mysql" \
    mariadb
