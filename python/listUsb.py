#!/usr/bin/env python

import sys
import usb.core

# find USB devices

devs = usb.core.find(find_all=True)

# loop through devices, printing vendor and product ids in decimal and hex
for dev in devs:
    # print("%04x:%04x" % ( dev.idVendor, dev.idProduct))
    try:
        xdev = usb.core.find(idVendor=dev.idVendor, idProduct=dev.idProduct)
        if xdev._manufacturer is None:
            xdev._manufacturer = usb.util.get_string(xdev, xdev.iManufacturer)
        if xdev._product is None:
            xdev._product = usb.util.get_string(xdev, xdev.iProduct)
        stx = '%04x:%04x: '+str(xdev._manufacturer).strip()+' = '+str(xdev._product).strip()
        print(stx % (dev.idVendor,dev.idProduct))
    except:
        pass