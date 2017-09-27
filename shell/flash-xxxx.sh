#!/bin/bash

SRC=`basename $0`
EXT=${SRC%%.sh}
EXT=${EXT##flash-}
echo $EXT

if [ "x$EXT" = "xbase" -o "x$EXT" = "xremote" ]; then
    set -x
    dfu-util -s 0x08000000:leave -d 0483:df11 -a 0 -D firmware-$EXT.bin
    set +x
fi
