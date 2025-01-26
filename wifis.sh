#!/bin/sh

# A simple script to show the current wifi connection status
interface="wlan0"
wifi_info=$(iwctl station $interface show)
state=$(echo "$wifi_info" | awk '/State/ {print $2}')
if [ "$state" = "connected" ]; then
    ssid=$(echo "$wifi_info" | awk -F 'Connected network ' '{print $2}' | awk '{print $1}')
    ipv4_address=$(echo "$wifi_info" | awk '/IPv4 address/ {print $3}')
    echo "$ssid" | tr -d '[:space:]'
    if echo "$ipv4_address" | grep -Pq '^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'; then
        echo "(1)"  # Valid IPv4 address
    else
        echo "(0)"  # Invalid IPv4 address
    fi
else
    echo "Disconnected"
fi
