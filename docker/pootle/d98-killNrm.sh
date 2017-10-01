#!/bin/bash

source d00-lib.sh

source cfg.sh

echo "kill $DNAME"
echo "----"
docker kill $DNAME
echo "rm $DNAME"
echo "----"
docker rm $DNAME
docker system prune

