#!/bin/bash

source d00-lib.sh

source cfg.sh

xmkdir $DD
cp -r src/. $DD/
touch $DD/.bash_history
