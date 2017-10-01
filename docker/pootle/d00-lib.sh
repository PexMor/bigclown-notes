#!/bin/bash

function xmkdir() {
    local DIR=$1
    if [ ! -d "$DIR" ]; then
        echo "-=[ making '$DIR'"
        mkdir -p "$DIR"
    else
        echo "-=[ '$DIR' dir exists"
    fi
}
