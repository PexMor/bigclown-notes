#!/bin/bash

source d00-lib.sh

source cfg.sh

docker run \
    -d \
    --privileged \
    --link mydb:mysql \
    --link redis:redis \
    --hostname $DNAME \
    --name $DNAME \
    -v $DD:/host \
    $N
