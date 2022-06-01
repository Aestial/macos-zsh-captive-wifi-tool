# Captive Wifi MAC Spoofing Z Shell script for Mac OS

The ``wifi-captive.command`` **Z Shell script for Mac OS** is used to connect a device to a Wifi network with a Captive Portal that cannot be accessed by the device.

This could happen when the device does not have a web browser installed like the case of an Apple TV or the network configuration tool does not allow the captive portal to be automatically accessed, the later being the case of the Nintendo 3DS.

Public WiFi networks are often configured with a Captive Portal in order to gather specific users information like in hotels or restaurants.

## Roadmap

1. ~~Add hints to the script to make it more user friendly.~~
2. ~~Add a way to store the captured SSIDs in a file.~~
3. ~~Add a way to select target SSID from the stored list.~~
4. Add a way to store the captured addresses in a file using a key-value data structure.
5. Add a way to select one of the stored addresses by the device's name.
6. Compatibility with the Bash Shell (for older versions of Mac OS with bash as the default shell).