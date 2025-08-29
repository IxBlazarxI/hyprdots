#!/bin/bash

# Use nmcli to list networks (SSID)
ssid=$(nmcli -f SSID,SECURITY device wifi list | awk 'NR>1 {print $1}' | uniq | rofi -dmenu -p "Wi-Fi SSID")

# Exit if nothing selected
[ -z "$ssid" ] && exit

# Check if the network is secured
secure=$(nmcli -f SSID,SECURITY device wifi list | grep "$ssid" | awk '{print $2}')

# If network is open, try to connect directly
if [[ "$secure" == "--" ]]; then
    nmcli device wifi connect "$ssid"
    exit
fi

# Prompt for password
pass=$(rofi -dmenu -password -p "Password for $ssid")

# Exit if no password entered
[ -z "$pass" ] && exit

# Try connecting with password
nmcli device wifi connect "$ssid" password "$pass"
