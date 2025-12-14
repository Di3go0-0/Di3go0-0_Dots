#!/bin/bash

if bluetoothctl show | grep -q "Powered: yes"; then
  if bluetoothctl info | grep -q "Connected: yes"; then
    echo '{"text": "Connected", "tooltip": "Bluetooth: Device connected", "class": "connected"}'
  else
    echo '{"text": "On", "tooltip": "Bluetooth: On, no connection", "class": "on"}'
  fi
else
  echo '{"text": "", "tooltip": "Bluetooth: Off", "class": "off"}'
fi
