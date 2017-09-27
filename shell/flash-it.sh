#!/bin/bash

set -x
dfu-util -s 0x08000000:leave -d 0483:df11 -a 0 -D firmware.bin
