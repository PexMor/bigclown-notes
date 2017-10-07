#!/bin/bash

DIR=$HOME/.bcpy

[ -d "$DIR" ] || python3 -mvirtualenv "$DIR"

source "$DIR/bin/activate"

pip install pyusb
