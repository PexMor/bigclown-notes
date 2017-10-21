# The Big Clown

* Core module - the center piece of the ecosystem (here your code runs)
* Modules - the sensors or actuators for your application
	* Active modules - like sensor (CO2) or relay
	* Mechanical and pasive modules - nice little extensions (like button or battery ~ which is not so passive :-)
* Tags - the smaller brothers of modules, with power and I2C connector (5-pin)

The Philips [I2C](https://en.wikipedia.org/wiki/I%C2%B2C) ~ short range wired digital communication bus for peripheral connection.
The utilization of I2C (with evetual help of I2C muxers) can be traced all over the IoT devices, and can be seen as an UART of MCUs.

An example of I2C peripherals available from Chinese Seeedstudio in their [Grove](https://www.seeedstudio.com/category/Grove-c-1003.html)/[GroveWiki](http://wiki.seeed.cc/Grove_System/) using [4-pin connector](https://www.seeedstudio.com/Grove-Universal-4-pin-connector-p-789.html). The one disadvantage of grove is that it is missing the INT signal, thus no way to wake the application MCU from deep sleep.

> **Note:** The Grove connector has [4 types](http://www.seeedstudio.com/blog/2016/03/09/tutorial-intro-to-grove-connectors-for-arduinoraspberry-pi-projects/): Digital, Analog, UART and I2C, whereas only the last one is compatible with Tag connector of BigClowns.

The ecosystem heart is beating on MCU from ST-Micro, namely their low-power line STM32L. This MCU is hosting both your application code and the core firmware. The core firmaware is radically simplifying the development of your own application code. The Big Clown has made a good deal of work by making the application part matter of call backs. That is done by utilizing so called [Inversion of control](https://en.wikipedia.org/wiki/Inversion_of_control) where you just setup some config values, cofigure call backs for event that sensors or timer can trigger and then the MCU goes to deep sleep (thus saving power and extending battery life).

The core module is also equipped with radio module [SPIRIT1](http://www.st.com/en/wireless-connectivity/spirit1.html) operating on [868MHz](https://en.wikipedia.org/wiki/Short_Range_Devices#SRD860) in Europe and [915MHz](https://en.wikipedia.org/wiki/ISM_band) in the US.

What us the difference [MCU vs. CPU](http://maxembedded.com/2011/06/mcu-vs-mpu/), sometimes the MCU is a CPU with small footprint, energy efficient and capable of real-time control. Real Time is worth to mention in the context of MCU and generally embedded devices as those are the ubiquitous brains of omnipresent electronics in todays western world.

## Core Module

The core module is the real heart, this is the place where you place your application code, this is the place where is connect other peripherals and this is the place where debugging is done.

![Core module](https://cdn.shopify.com/s/files/1/1716/4105/products/Product_WebPhotos_Core_Module_600x382.png)

The authors has genrously provided many details on [core module](https://shop.bigclown.com/products/core-module) including it's [schemantics](https://github.com/bigclownlabs/bc-hardware/blob/master/out/bc-module-core/bc-module-core-rev-1-3-sch.pdf).

For your convenience the module documentation has nice overview picture, one of those PIN-out diagrams that can help when building designs with it.

![pinout diagram of the core module](https://doc.bigclown.cz/images/core-module/core-module.png)

## Modules

Modules are extension to the core module similarly as Arduino Shields or Raspberry Pi Hats are to other ecosystems.

### Active modules

The big clown actually has two form factors of those modules.

Small ones:

* Climate module
* ...


### Machanical and passive

With one exception of battery modules these modules has no active electronics on them.

Small ones:

* Button 
* Cover module
* Tag module
* Small battery module (2xAAA) - output voltage 3.3V ?

Large ones:

* Battery module (4xAAA) - output voltage 3.3V?
* Base module
* Power module (well some ICs are there)

## Tags

Those little modules are intended to be used as additional peripherals connected to the core:

* directly (only one module plugged into 15-19 pins of core module)
* base module - where you can connect 2 tags (one directly and one to base module)
* [tag module](https://obchod.bigclown.cz/products/tag-module) - where you have 6 connectors for Tags divided into two groups each connected to one I2C bus
* encoder module
* CO2 module
* battery module
* ...



