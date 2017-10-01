#!/bin/bash

source cfg.sh

B=`date +%s`
docker build \
    -f Dockerfile.debug \
    -t $N \
    . 2>&1 | tee tmp-log.txt
E=`date +%s`
D=$[E-B]
echo "took: ${D}s"


