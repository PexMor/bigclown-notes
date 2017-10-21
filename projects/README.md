# Projects

[Baby steps](babysteps.md) with the Big Clown's Core Module.

> *ToDo: describe MQTT message evolution*

```
# Original messages (now obsolete)
["remote/thermometer/i2c0-49", {"temperature": [21.56, "\u2103"]}]
["remote/humidity-sensor/i2c0-40", {"relative-humidity": [78.3, "%"]}]


["<module-A-id>/push-button/-/event-count", 0]
["<module-A-id>/push-button/-/event-count", 1]
["<module-A-id>/thermometer/0:1/temperature", 18.81]
["<module-A-id>/hygrometer/0:2/relative-humidity", 73.1]
["<module-B-id>/thermometer/0:1/temperature", 21.50]
["<module-C-id>/hygrometer/0:4/relative-humidity", 65.9]
["<module-C-id>/thermometer/0:0/temperature", 17.69]
["<module-C-id>/lux-meter/0:0/illuminance", 19.9]
["<module-C-id>/barometer/0:0/pressure", 98587.75]
["<module-C-id>/barometer/0:0/altitude", 230.12]
["<module-C-id>/thermometer/0:1/temperature", 18.12]
["<module-C-id>/hygrometer/0:4/relative-humidity", 64.9]
["<module-A-id>/thermometer/0:1/temperature", 18.81]
```

### The Module C

It looks like this actually, and consists of the climate module, core module and mini battery module.

![Module C](https://lh3.googleusercontent.com/wpcu1X8usz5yixM2haowEgIWScyE4uz-4_09-yuFXgzCxNymtoEbf1aixhD-W7vxU8FCmZTYFhL_zbxA7MsZSxgpzCMhUdVDq6VEyb5JRrYgFI83P_IVpDrKSCgcucdqTLYZupQy-K5VOtV0M7BPJalkglOicybORQ09Yq0UYRijGvKmLJ42Z1M3Sau45IRNAw8sDtLbNX2rhc-nZa064SGgrO_Y06hGq4lMYHDC5ywRvKZvOfgXGCqBRutO9X55Vfo1q2h0VSYUelFUo8Toq-BYUpEoNp7hUnYPawzSR_uzqMBezzforBPhj_MToeDzA02ZZMN_cHX4tl1io0sG4G7co5TtGZXSKlPXe2fNQ4Oc__YsGSkucyuTAfXZF3brQbTIvG2qGpH2ASC-D09RlZELrdjovogwFjppox3SvY3_RGGa4UDQwifxdogKUD74N5tsIPI4zj6uxbegvEMFZXBiAV5_C4t7DAd5yXW6l6LHgjiu0QSuHqaLfeyoOr1lIALQKTuTsl7ZqznGGbI4lZSoHPvR8mwL5u_CfM4cSJ968O47zh-tl5njalFyrfZmU6rKOGe8Idq4287IRfrXNZ-rRWJEuU7hlSD0HbmmOUnsFh0UlQrXOLteW7Bwrcji7jVoDRMJgYEl1Zu7WCDw7iOCWJMcb-u_CjJ7=w251-h335-no)

*The Unicode character \u2103 stands for [degree of Celsius](http://www.fileformat.info/info/unicode/char/2103/index.htm) - two glyph symbol as one character, this was omited in later version of procol as redundant information.*

## Climate station

What such climate station does and how does it looks like?

* [NPS Weather station](https://science.nature.nps.gov/im/units/swan/monitor/weather.cfm) - National Park Service (USA)
* [Help To local farmers](https://maritzburgsun.co.za/37240/weather-station-to-help-local-farmers/) - Maritzburg Sun ([RSA](https://en.wikipedia.org/wiki/UMshwathi_Local_Municipality) - South Africa)
* [MAE WS](http://mea.com.au/soil-plants-climate/weather/weather-stations) - MAE weather stations (Adelaide - South Australia)
* [Condrad WS](http://www.conrad.com/ce/en/overview/0514060/Weather-stations) - Conrad Wheather stattions (Germany)
* [Wheather Underground community](https://www.wunderground.com/weatherstation/overview.asp) - helps you build and/or [buy](https://www.wunderground.com/weatherstation/buyingguide.asp) your own and get connected to their network.

John Shovic's [project Curacao](http://www.switchdoc.com/project-curacao-project-page/) shared trough [SwitchDoc Labs](http://www.switchdoc.com/).

