# Baby steps

In March 2017 I have become a proud owner of Big Clown Basic Wireless set. Unfortunately it was resting at the shelf for almost half a year! After that looooong period of time I came back to little gadget at the beginning of autumn. After a busy months at work it was a relieve to play with couple of well made and documented piece of hardware. I was always software engineer biased towards hardware. And I still consider the hardware to be the solid base for any software games.

![Image of Wireless set](https://cdn.shopify.com/s/files/1/1443/0540/products/Product_WebPhotos_Basic_Wireless_Set_600x382.png)

[Basic Wireless Set](https://obchod.bigclown.cz/products/basic-wireless-set)

As you can see the set consist of two [core modules](https://shop.bigclown.com/products/core-module), one [base module](https://shop.bigclown.com/products/base-module), one [battery module](https://shop.bigclown.com/products/battery-module) and of course a [humidity tag](https://shop.bigclown.com/products/humidity-tag). And whole lot of good spirit of Big Clown accompanied with necessary red nose to get you out of any troubles.

## Hardware

![Core module](https://cdn.shopify.com/s/files/1/1716/4105/products/Product_WebPhotos_Core_Module_600x382.png)

[core module](https://shop.bigclown.com/products/core-module) and it's [schemantics](https://github.com/bigclownlabs/bc-hardware/blob/master/out/bc-module-core/bc-module-core-rev-1-3-sch.pdf)

It's heart is beating at the STM32L series CPU ([more on the web](https://shop.bigclown.com/products/core-module)) with emphais on low power consumption. Below is a pinout diagram that helped me a lot when I needed to connect other pieces of hardware or non-BC peripherals.

![pinout diagram of the core module](https://doc.bigclown.cz/images/core-module/core-module.png)

First thing I have to learn was how to get into DFU mode (Device Firmare Upgrade) aka flashing the device. It is [described at the web site](https://doc.bigclown.com/core-module-flashing.html) but actually it is good to memorize :-) And so again to remember:

1. press and **hold** the **Boot ~ 'B'** button *- to give the CPU indication the you want to enter DFU/flashing mode*
2. trigger reset of the CPU by pressing and releasing **Reset ~ 'R'** button
3. release the **Boot ~ 'B'** button *- it's state was read after reset*

> **Note:** The DFU more is further described at STMicroelectronics site [PDF](http://www.st.com/content/ccc/resource/technical/document/application_note/6a/17/92/02/58/98/45/0c/CD00264379.pdf/files/CD00264379.pdf/jcr:content/translations/en.CD00264379.pdf). There are plans to simplify this procedure but let's see what will come.

## Software

You might find as I did, that there are multiple names for the software for microcontrollers. Sometimes it is called **firmware** resembling the fact that the software is downloaded to the chip in factory and it is actually an essetial part of the hardware in order to work. It is also worth to mention that the software is not only a custom function but is has kind of operating system embedded in it. Therefore with **firmware** you are actually loading more that just a blinking led loop but also all the stuff that makes the whole circus will work.

> **Note:** Usualy the process of loading the embedded device Flash/EEPROM with software tends to be named as download. And this download term is widely used. The reason for using this word and not the complimentary upload is probably driven by the fact that the flashing is driven by the chip bootloader it there is a notion of that the chip is downloading the binary in the control role.

### Toolchain

Compared to the hardware which you in case of Big Clown receive already set-up and ready for use the software part needs some effort to be done. In certain cases it might not be that easy. But no worries! Me and many others mastered it. And remember all issues you face are just transient discomfort.

You actually need two essential components in order to SW DIY. And if you have your software already compiled and turned into flashable binary (*.bin) then the only tool you need is DFU flasher in my case here it was recommended dfu-util (Win,Lin,MacOSX).

* [Toolchain](https://doc.bigclown.com/core-module-setup-macos.html) as described that BigClown web site, but here installed using brew
* [DFU Utils](http://dfu-util.sourceforge.net/) at asource forge, also via brew

Let's got and install the gcc compiler, linked, library manager and the build utilities like make, etc.

```bash
$ brew install Caskroom/cask/gcc-arm-embedded
# command output is omitted here it takes some time to download and install

# to verify that the compiler is ready just run
$ arm-none-eabi-gcc --version
arm-none-eabi-gcc (GNU Tools for ARM Embedded Processors) 6.2.1 20161205 (release) [ARM/embedded-6-branch revision 243739]
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

Nest step was to install the firmware flasher aka dfu-util. This is done again by utilizin the brew magic on the MacOSX command line:

```bash
$ brew install dfu-util
$ dfu-util -l
dfu-util 0.9

Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
Copyright 2010-2016 Tormod Volden and Stefan Schmidt
This program is Free Software and has ABSOLUTELY NO WARRANTY
Please report bugs to http://sourceforge.net/p/dfu-util/tickets/

Deducing device DFU version from functional descriptor length
Found Runtime: [05ac:821a] ver=0042, devnum=7, cfg=1, intf=3, path="250-3", alt=0, name="UNKNOWN", serial="UNKNOWN"
Found DFU: [0483:df11] ver=2200, devnum=5, cfg=1, intf=0, path="250-3", alt=2, name="@DATA Memory /0x08080000/2*3Ke", serial="7FB4A4356231"
Found DFU: [0483:df11] ver=2200, devnum=5, cfg=1, intf=0, path="250-3", alt=1, name="@Option Bytes  /0x1FF80000/01*032 e", serial="7FB4A4356231"
Found DFU: [0483:df11] ver=2200, devnum=5, cfg=1, intf=0, path="250-3", alt=0, name="@Internal Flash  /0x08000000/1536*128g", serial="7FB4A4356231"
```

> **Note:** I have an axe to grind here and you could check this repo for [python tools](https://github.com/PexMor/bigclown-notes/tree/master/python). There is the listUSB.sh/py which also list the devices present on USB. It is worth to say that it does not show all details as dfu-utils do but gives nice concise usb list (inspired by lsusb on linux).

In the above dfu-util list the **7FB4A4356231** is the serial number or identifier of the device, which is important in order to recognize the particular device (e.g. if you have more of them). As you might also see is that that particular device offers three *virtual* devices(memory ranges):

* "@DATA Memory /0x08080000/2*3Ke"
* "@Option Bytes  /0x1FF80000/01*032 e"
* "@Internal Flash  /0x08000000/1536*128g"

This was my cross check that I have presses the buttons in propper way.

After these two steps you and up in a state (on MacOS X 10.12) you can actually start building your programs. Of course you can choose any IDE or just and Atom to make your life easier. But as a start you can just take the source and build it.

```bash
# install the programmer's sanity tool
# To be honest I can't imagine my work without git (Thanks Linus!)
$ brew install git

# get the software including the SDK (done by --recursive parameter)
$ git clone --recursive https://github.com/bigclownlabs/bc-core-module.git 

Cloning into 'bc-core-module'...
remote: Counting objects: 152, done.
remote: Total 152 (delta 0), reused 0 (delta 0), pack-reused 152
Receiving objects: 100% (152/152), 31.95 KiB | 0 bytes/s, done.
Resolving deltas: 100% (63/63), done.
Submodule 'sdk' (https://github.com/bigclownlabs/bc-core-module-sdk.git) registered for path 'sdk'
Cloning into '/Users/moravekp/bc/bc-core-module/sdk'...
remote: Counting objects: 5314, done.
remote: Compressing objects: 100% (40/40), done.
remote: Total 5314 (delta 18), reused 34 (delta 12), pack-reused 5262
Receiving objects: 100% (5314/5314), 14.16 MiB | 1.42 MiB/s, done.
Resolving deltas: 100% (2759/2759), done.
Submodule path 'sdk': checked out '9d8452f189b305f83b5b7040cbdef1fa9d3a09c0'

# jump into the root of the project
$ cd bc-core-module

# and build it
$ make

Clean output ...
Compiling: app/application.c
#
# here is 139 lines of SDK compilation omitted
#
Linking object files...
Size of sections:
   text	   data	    bss	    dec	    hex	filename
  16240	   1212	   5528	  22980	   59c4	out/debug/firmware.elf
Creating out/debug/firmware.bin from out/debug/firmware.elf...

# look for the binaries produced
$ find out -type f

out/debug/firmware.bin
out/debug/firmware.elf
out/debug/firmware.map

# and now you can burn the firmware into the device's flash memory
$ dfu-util -s 0x08000000 -d 0483:df11 -a 0 -D out/debug/firmware.bin

dfu-util 0.9

Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
Copyright 2010-2016 Tormod Volden and Stefan Schmidt
This program is Free Software and has ABSOLUTELY NO WARRANTY
Please report bugs to http://sourceforge.net/p/dfu-util/tickets/

dfu-util: Invalid DFU suffix signature
dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
Deducing device DFU version from functional descriptor length
Opening DFU capable USB device...
ID 0483:df11
Run-time device DFU version 011a
Claiming USB DFU Interface...
Setting Alternate Setting #0 ...
Determining device status: state = dfuERROR, status = 10
dfuERROR, clearing status
Determining device status: state = dfuIDLE, status = 0
dfuIDLE, continuing
DFU mode device DFU version 011a
Device returned transfer size 2048
DfuSe interface name: "Internal Flash  "
dfu-util: Non-valid multiplier 'g', interpreted as type identifier instead
Downloading to address = 0x08000000, size = 17452
Download	[=========================] 100%        17452 bytes
Download done.
File downloaded successfully
```

So now I was at the point when I wanted to make the wireless circus fly:-) Unfortunately the [Basic Wireless Set](https://obchod.bigclown.cz/products/basic-wireless-set) has no links to the appropriate documentation or kind of quick start. It is probably cause by rapid development which breaks some historical links. It should be better organized though in near future.

[bcp-wireless-circus](https://github.com/bigclownlabs/OBSOLETE-bcp-wireless-circus)
and it's [binary releases](https://github.com/bigclownlabs/OBSOLETE-bcp-wireless-circus/releases)

Quick fix was needed for remote sensor in order to hear from it more often.

```diff
diff --git a/remote/app/application.c b/remote/app/application.c
index cfb515c..d770f87 100644
--- a/remote/app/application.c
+++ b/remote/app/application.c
@@ -1,5 +1,5 @@
 #include <application.h>
-#define UPDATE_INTERVAL 300000
+#define UPDATE_INTERVAL 10000

 bc_led_t led;
```

After updating the source code of application as shown in above diff I have built the binaries and flashed them [flash-*](https://github.com/PexMor/bigclown-notes/tree/master/shell) expecting that firmware-base.bin and firmware-remote.bin are collected in the same directory.

When that was done batteries plugged into remote, I could have seen:

```bash
$ ./tty.py
/dev/tty.usbmodem56231
["remote/thermometer/i2c0-49", {"temperature": [21.56, "\u2103"]}]
["remote/humidity-sensor/i2c0-40", {"relative-humidity": [78.3, "%"]}]
["base/thermometer/i2c0-49", {"temperature": [22.88, "\u2103"]}]
["remote/thermometer/i2c0-49", {"temperature": [21.62, "\u2103"]}]
["remote/humidity-sensor/i2c0-40", {"relative-humidity": [76.5, "%"]}]
["base/thermometer/i2c0-49", {"temperature": [22.88, "\u2103"]}]
```

[JSON Lines](http://jsonlines.org/) - aka new line `\n` delimited json records, the `\n` within the json itself is `c` escaped like `\n`.

> **Note:** `\u2103` is degreee of celsius encoded as one character in Unicode (see [fileformat info](http://www.fileformat.info/info/unicode/char/2103/index.htm), [ graphemica](http://graphemica.com/%E2%84%83) or [codepoint](https://codepoints.net/U+2103)).

### Update 2017/10/11

[The new Remote](https://github.com/bigclownlabs/bcf-generic-node)([git](https://github.com/bigclownlabs/bcf-generic-node.git)) has emerged and it's conterpart [the USB gateway](https://github.com/bigclownlabs/bcf-usb-gateway)([git](https://github.com/bigclownlabs/bcf-usb-gateway.git)) it is worth to mention that it has much better code readability. An also the `dfu-util` is now wrapper into nice python utility which has more capabilities:

* installable from python directly `pip install bcf`
* two firware download modes
	* USB DFU (original core module)
	* serial (plain serial with CTS('R')+DTR('B') mode switch
* flash from local or remote(url) repository
* download/update from remote repository
* own or stock firmware (you do not have to build the binary)

```bash
# get the base and remote (now usb gateway and generic node)
git clone --recursive https://github.com/bigclownlabs/bcf-usb-gateway.git
git clone --recursive https://github.com/bigclownlabs/bcf-generic-node.git

# build them
cd bcf-usb-gateway
make
# or make release
cd ..

cd bcf-generic-node
make
# or make release
cd ..

# check whether 
find bcf-usb-gateway/out -type f
find bcf-generic-node/out -type f

# MacOSX
# note: -p --path <bus-port. ... .port>
# the above parameter can be used for selecting appropriate device
dfu-util -s 0x08000000:leave -d 0483:df11 -a 0 -D firmware.bin
```

When it is run through the tty.py which reads the serial port

```bash
$ ./tty.py
/dev/tty.usbmodemFA131
["836d1982194a/push-button/-/event-count", 0]
["836d1982194a/push-button/-/event-count", 1]
["836d1982194a/push-button/-/event-count", 2]
["836d1982194a/push-button/-/event-count", 3]
```

The new [bcf](https://github.com/bigclownlabs/bch-firmware-utility.git) is actually a python installer that has almost no documentation at the moment thus you have to dig through the docs a little bit.

```bash
# big clown firmware (bcf)
$ pip install bcf

# run it to get short help
$ bcf
usage: bcf [-h] [-v] COMMAND ...
bcf: error: too few arguments

# bcf version should be printed also in help screen
$ bcf -h
usage: bcf [-h] [-v] COMMAND ...

BigClown Firmware Flasher

positional arguments:
  COMMAND
    update       update list of available firmwares
    list         list firmwares
    flash        flash firmware
    devices      show devices
    search       search in firmwares names and descriptions
    pull         pull firmware to cache
    clean        clean cache
    create       create new firmware
    clone        download firmware to file
    help         show help

optional arguments:
  -h, --help     show this help message and exit
  -v, --version  show program's version number and exit
```

```bash
# an error that appears upon update
# ugly: json.loads(response.read().decode('utf-8'))
# reading: https://api.github.com/orgs/bigclownlabs/repos?page=1
# not fail safe mode
$ bcf update
Traceback (most recent call last):
  File "/usr/local/bin/bcf", line 11, in <module>
    sys.exit(main())
  File "/usr/local/lib/python2.7/site-packages/bcf/cli.py", line 210, in main
    repos.update()
  File "/usr/local/lib/python2.7/site-packages/bcf/github_repos.py", line 102, in update
    gh_repos = self.api_get('https://api.github.com/orgs/bigclownlabs/repos?page=%d' % page)
  File "/usr/local/lib/python2.7/site-packages/bcf/github_repos.py", line 96, in api_get
    return json.loads(response.read().decode('utf-8'))
  File "/usr/local/Cellar/python/2.7.14/Frameworks/Python.framework/Versions/2.7/lib/python2.7/json/__init__.py", line 339, in loads
    return _default_decoder.decode(s)
  File "/usr/local/Cellar/python/2.7.14/Frameworks/Python.framework/Versions/2.7/lib/python2.7/json/decoder.py", line 364, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/local/Cellar/python/2.7.14/Frameworks/Python.framework/Versions/2.7/lib/python2.7/json/decoder.py", line 382, in raw_decode
    raise ValueError("No JSON object could be decoded")
ValueError: No JSON object could be decoded
```

List serial devices

```bash
# on macosx
ls /dev/tty.*
```

Github API to get list of repositories, next extract firmwares (starting with bcf)

```bash
curl https://api.github.com/orgs/bigclownlabs/repos?page=1
```

Cache Directories shall be printable `/Users/moravekp/Library/Caches/bcf` using the utility itself, in order to be able to remove that directory when corrupted or the structure has changed.

```python
# add this into the cli.py for debugging...
#
user_cache_dir = appdirs.user_cache_dir('bcf')
print(user_cache_dir)
```

? OTA Over the air firware flasher ?

? What happens when there is more core modules connected ?

**... here comes the cloud (To-Do) ...**

## Resources

* [schemantics of the core module](https://github.com/bigclownlabs/bc-hardware/blob/master/out/bc-module-core/bc-module-core-rev-1-3-sch.pdf)
* [miscelaneous board pinouts](http://www.pighixxx.com/test/pinoutspg/boards/)
