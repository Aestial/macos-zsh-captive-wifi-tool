#!/bin/zsh

SSID_FILE="ssids.txt"
MAC_ADDRESS_FILE="mac-address.txt"

echo "Captive Portal MAC spoofing script 📶."
# Displaying current MAC address
current_mac=`ifconfig en0| grep ether | awk '{print $2}'`
echo "Current MAC address: $current_mac"
# Prompting user for disconnecting target device
echo "Please turn off or disconnect your target device and press enter."
read

ssid=""
declare -a ssid_values

# Looking for file with SSIDs or creating it
if find "$SSID_FILE" -type f 
then
    # Displaying previous stored SSIDs options
    echo "Previous stored SSIDs:"
    count=0
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Add each line to an array
        value=$(echo $line)
        ssid_values+=("$value")
        # Print option
        count=$((count+1))
        echo "$count. $value"
    done < "$SSID_FILE"

    echo "Number of values read from file: ${#ssid_values}"
    # Option for adding new SSID
    echo "0. Enter new SSID"
    # Prompting user for select SSID from stored
    echo "Select SSID option:"
    read ssid_option
    # Option validation
    while [[ $ssid_option -gt $count ]] || [[ $ssid_option -lt 0 ]] || [[ $ssid_option == "" ]]
    do
        echo "Invalid option. Please select a valid option."
        echo "Select SSID option:"
        read ssid_option
    done

    # If option is 0, prompt for new SSID
    if [[ $ssid_option -eq 0 ]]; then
        echo "Enter captive WiFi SSID:"
        read ssid
        if [[ $ssid == "" ]]; then
            echo "No SSID entered. Exiting."
            return ""
        fi
        echo "$ssid" >> "$SSID_FILE"
    # If option is not 0, return selected SSID
    else
        ssid=${ssid_values[$ssid_option]}
        echo "Selected SSID: $ssid"
    fi
else
    echo "No previous stored SSIDs."
    # Prompting user for captive SSID
    echo "Enter captive WiFi SSID:"
    read ssid
    if [[ $ssid == "" ]]; then
        echo "No SSID entered. Exiting."
        return ""
    fi
    # Create file with SSID
    echo "$ssid" > "$SSID_FILE"
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
sudo ifconfig en0 ether $current_mac
echo "Original MAC address restored: `ifconfig en0| grep ether | awk '{print $2}'`"
echo "Press enter to continue."
read
# Restoring original WiFi connection
echo "Connecting current device to $ssid..."
sudo networksetup -setairportnetwork en0 $ssid
echo "Fill information in captive site and press enter to continue."
open -a /Applications/Firefox.app
read

echo "Done." 