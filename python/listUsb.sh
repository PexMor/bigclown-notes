#!/bin/bash

DIR=$HOME/.bcpy

source "$DIR/bin/activate"

python ${0%%.sh}.py

