#!/bin/bash

source env/bin/activate
source cfg

mkdir -p trans-en

for FI in orig-cs/*; do
    BN=`basename "$FI"`
    KN=${BN%%.cs.md}
    TLANG=en
    po2txt -t "$FI" "$WD/translations/$PROJ/$TLANG/$KN.po" "trans-en/$KN.en.md"
done
