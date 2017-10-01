#!/bin/bash

source d00-lib.sh

source cfg.sh

xmkdir $DD/orig-cs
cp -r src/. $DD/
cp -r orig-cs/. $DD/orig-cs
touch $DD/.bash_history
pushd $DD
ln -s env/lib/python2.7/site-packages/pootle workdir
mkdir -p workdir/test-doc/templates
