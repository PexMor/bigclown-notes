#!/usr/bin/env python3

import serial
import sys

# sys.setdefaultencoding('utf-8')

ser = serial.Serial('/dev/tty.usbmodemFA131')
print(ser.name)
while True:
    txt = ser.read()
    sys.stdout.write(txt.decode("utf-8"))

ser.close()
