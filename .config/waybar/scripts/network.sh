#!/usr/bin/env bash

iface=$(ip route | awk '/default/ {print $5; exit}')

if [ -z "$iface" ]; then
    printf '{"text": "󰈂  Disconnected", "tooltip": "Disconnected", "class": "disconnected"}\n'
    exit 0
fi

ip_cidr=$(ip addr show "$iface" | awk '/inet / {print $2; exit}')
ip_only=$(echo "$ip_cidr" | cut -d'/' -f1)
cidr=$(echo "$ip_cidr" | cut -d'/' -f2)

if [ -d "/sys/class/net/$iface/wireless" ]; then
    essid=$(iwctl station "$iface" show 2>/dev/null | awk '/Connected network/ {print $NF}')
    text="󰖩  ${essid}"
    tooltip="${essid}\n${ip_only}/${cidr}"
else
    text="󰈁  ${iface}"
    tooltip="${iface}\n${ip_only}/${cidr}"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "connected"}\n' "$text" "$tooltip"
