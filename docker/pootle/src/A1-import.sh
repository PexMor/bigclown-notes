#!/bin/bash

source env/bin/activate
source cfg

for FI in orig-cs/*; do
    BN=`basename "$FI"`
    KN=${BN%%.cs.md}
    echo "$BN KN='$KN'"
    mkdir -p $WD/translations/$PROJ/templates
    txt2po -P --flavour=mediawiki "$FI" "$WD/translations/$PROJ/templates/$KN.pot"
    TLANG=en
    mkdir -p $WD/translations/$PROJ/$TLANG
    cp "$WD/translations/$PROJ/templates/$KN.pot" "$WD/translations/$PROJ/$TLANG/$KN.po"
done
