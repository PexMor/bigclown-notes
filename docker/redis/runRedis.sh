#!/bin/bash

BD=$HOME/pootle
D=$BD/redis

[ -d "$D" ] || mkdir -p "$D"

docker run \
    -d \
    --name redis \
    --hostname redis \
    -v $D:/data \
    redis:alpine
# -server
# --appendonly yes
