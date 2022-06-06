# Captive Wifi MAC Spoofing Z Shell script for Mac OS

The ``wifi-captive.command`` **Z Shell script for Mac OS** is used to connect a device to a Wifi network with a Captive Portal that cannot be accessed by the device.

This could happen when the device does not have a web browser installed like the case of an Apple TV or the network configuration tool does not allow the captive portal to be automatically accessed, the later being the case of the Nintendo 3DS.

Public WiFi networks are often configured with a Captive Portal in order to gather specific users information like in hotels or restaurants.

## Usage steps
1. Determine the MAC address of the device.
2. Determine the SSID of the network.
3. If already connected to the wireless network, power off or unplug the device to disconnect it.
4. Execute the script with one of the following:
    - Double click on the script to run it, 
    - Drag and drop it to the Terminal window,
    - Open the Terminal window, navigate to script location and enter the command ``./wifi-captive.command``.
5. Follow the instructions on the screen.

## **Notes**
1. *The script is tested on macOS Monterey (12.3.1).*
2. *This version of the script uses the en0 network interface as default.*
3. *This version of the script uses the Firefox browser to access the captive portal and verify internet connection.*

## Script process
1. Ask user to disconnect the device from the network.
2. Choose or capture the WiFi network SSID.
3. Disconnect Mac computer from the network and remove the network profile.
4. Choose or capture the MAC address of the device.
5. *Spoof* the MAC address of the device.
6. Connect to the network with the spoofed MAC address.
7. Ask user to fill the Captive Portal form, submit it and verify internet connection.
8. Disconnect Mac computer from the network and remove the network profile.
9. Restore the original MAC address of the Mac computer.
10. Connect to the network with the original MAC address.
11. Ask user to verify internet connection (if needed submit again Captive Portal form).

## References
1. [Rob Pickering's article on *How to use an Apple TV with Hotel WiFi*](https://robpickering.com/using-an-apple-tv-on-hotel-wifi-captive-portal/)
2. [Captive Portal](https://en.wikipedia.org/wiki/Captive_portal)

## Roadmap
1. ~~Add hints to the script to make it more user friendly.~~
2. ~~Add a way to store the captured SSIDs in a file.~~
3. ~~Add a way to select network SSID from the stored list.~~
4. ~~Add a way to store the captured addresses with their device's name in a file.~~
5. ~~Add a way to select one of the stored addresses by choosing the device's name.~~
6. ~~Execute find command silently (hide output).~~
7. Add a way to select the network interface name to use (currently hardcoded to en0).
8. Add a way to select the browser to use (currently hardcoded to Firefox).
9. Save persistency files in dedicated MacOS Application files directory.
10. Simplify redundant code. 
11. Refactor the script to make it more readable.
