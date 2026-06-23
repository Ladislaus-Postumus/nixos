#!/usr/bin/env bash

# Fetch active connection details: TYPE, SSID, SIGNAL
# We use 'con show --active' to reliably identify Ethernet vs Wifi
connection_info=$(nmcli -t -f TYPE,NAME,DEVICE con show --active | head -n1)

if [ -z "$connection_info" ]; then
    echo "󰲜"
    exit 0
fi

type=$(echo "$connection_info" | cut -d: -f1)
name=$(echo "$connection_info" | cut -d: -f2)

if [[ "$type" == *"ethernet"* ]]; then
    # Ethernet Output
    echo "󰈀 $name"
else
    # WiFi Output - Get signal strength for the specific device
    signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^*' | cut -d: -f2)
    
    # Determine icon based on strength
    if (( "$signal" >= 80 )); then
        icon="󰤨"
    elif (( "$signal" >= 60 )); then
        icon="󰤥"
    elif (( "$signal" >= 40 )); then
        icon="󰤢"
    elif (( "$signal" >= 20 )); then
        icon="󰤟"
    else
        icon="󰤯"
    fi
    
    echo "$icon $name"
fi
