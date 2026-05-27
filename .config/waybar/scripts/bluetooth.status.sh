#!/bin/bash

get_status() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        if bluetoothctl info | grep -q "Connected: yes"; then
            device=$(bluetoothctl info | grep "Name:" | awk '{print $2}')
            echo "{\"text\": \"󰂱\", \"tooltip\": \"Bluetooth: $device\", \"class\": \"connected\"}"
        else
            echo '{"text": "󰂯", "tooltip": "Bluetooth: On", "class": "on"}'
        fi
    else
        echo '{"text": "󰂲", "tooltip": "Bluetooth: Off", "class": "off"}'
    fi
}

get_status

bluetoothctl monitor | while read -r line; do
    case "$line" in
        *"Powered"*|*"Connected"*|*"Disconnected"*)
            get_status
            ;;
    esac
done
