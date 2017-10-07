# Java for uC

How to access uC from java.

## DFU from java

Device firmware upgrade, defined by [USB Standard](http://www.usb.org/developers/docs/devclass_docs/DFU_1.1.pdf).

[OpenMoko:DFU](http://wiki.openmoko.org/wiki/USB_DFU_-_The_USB_Device_Firmware_Upgrade_standard)

### Flop Programmer

Java application and applet. Targeted to Atmel.

*Hint for macosx gradle install:**

```bash
brew install gradle
```

* [github:kairyu/flop](https://github.com/kairyu/flop)
* [Dfu.java](https://github.com/kairyu/flop/blob/master/programmer/src/main/java/com/github/kairyu/flop/programmer/dfu/Dfu.java)
* [DFU-Programmer](https://dfu-programmer.github.io/)

### STM32 Programmer

* [github:UmbrelaSmart/android-stm32-dfu-programmer](https://github.com/UmbrelaSmart/android-stm32-dfu-programmer)

https://github.com/UmbrelaSmart/android-stm32-dfu-programmer.git

#### Usb4Java

[libusb](http://usb4java.org/quickstart/libusb.html)

### Original programmer

Written in c [dfu-util](https://github.com/dsigma/dfu-util).

ST Microelectronics: [The DFU Protocol](http://www.st.com/content/ccc/resource/technical/document/application_note/6a/17/92/02/58/98/45/0c/CD00264379.pdf/files/CD00264379.pdf/jcr:content/translations/en.CD00264379.pdf)(pdf)
