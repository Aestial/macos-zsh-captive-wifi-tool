#!/bin/zsh
echo "Captive Portal MAC spoofing script 📶"
# Displaying current MAC address
CURRENT_MAC=`ifconfig en0| grep ether | awk '{print $2}'`
echo "Current MAC address: $CURRENT_MAC"
# Prompting user for disconnecting target device
echo "Please turn off or disconnect your target device and press enter."
read -r
# Prompting user for captive SSID
echo "Enter captive WiFi SSID:"
read ssid
if [[ $ssid == "" ]]; then
    echo "No SSID entered. Exiting."
    exit
fi
# Disconnecting from WiFi
sudo networksetup -setnetworkserviceenabled Wi-Fi off
sudo networksetup -removepreferredwirelessnetwork en0 $ssid 
sudo networksetup -setnetworkserviceenabled Wi-Fi on
# Prompting user for new MAC address
echo "Enter target device's MAC address:"
read target_mac
if [[ $target_mac == "" ]]; then
    echo "No MAC address entered. Exiting."
    exit
fi
# Spoofing MAC address
sudo ifconfig en0 ether $target_mac
echo "New MAC address `ifconfig en0| grep ether | awk '{print $2}'`"
# Connecting to WiFi with new MAC address
echo "Connecting target device to $ssid..."
sudo networksetup -setairportnetwork en0 $ssid
echo "Fill information in captive site and press enter to continue."
open -a /Applications/Firefox.app
read
# Disconnecting from WiFi
sudo networksetup -setairportpower en0 off
sudo networksetup -removepreferredwirelessnetwork en0 $ssid 
sudo networksetup -setairportpower en0 on
# Restoring original MAC address
sudo ifconfig en0 ether $CURRENT_MAC
# Restoring original WiFi connection
echo "Connecting current device to $ssid..."
sudo networksetup -setairportnetwork en0 $ssid
echo "Fill information in captive site and press enter to continue."
open -a /Applications/Firefox.app
read

echo "Done."