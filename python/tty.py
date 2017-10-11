#!/usr/bin/env python3

import serial
import sys
import time
import datetime
# sys.setdefaultencoding('utf-8')

ser = serial.Serial('/dev/tty.usbmodemFA131')
print("serial.name", ser.name)
try:
    while True:
        txt = ser.readline()
        ts = time.time()
        timestr = time.strftime("%Y%m%d")
        recstr = (''.join(txt.decode("utf-8"))).strip()
        print(recstr)
        with open(timestr+".txt", "a") as myfile:
            myfile.write(str(ts))
            myfile.write(":")
            myfile.write(recstr)
            myfile.write("\n")
            myfile.flush()
            myfile.close()
except KeyboardInterrupt as e:
    print("User abort")

ser.close()
