#!/bin/bash

# Script para alternar entre layouts en Hyprland
log_file="$HOME/toggle-layout.log"
echo "---" >> $log_file
date >> $log_file
echo "Running toggle-layout.sh" >> $log_file

current_layout=$(hyprctl getoption general:layout | awk '{print $2}')
echo "Current layout: $current_layout" >> $log_file

if [ "$current_layout" == "dwindle" ]; then
    hyprctl keyword general:layout master
    echo "Switched to master layout" >> $log_file
else
    hyprctl keyword general:layout dwindle
    echo "Switched to dwindle layout" >> $log_file
fi

