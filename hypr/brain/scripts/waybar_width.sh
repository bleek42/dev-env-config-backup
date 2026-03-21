#!/usr/bin/env bash

## ? Get the current monitor size and position
monitor_info=$(hyprctl monitors | sed -n '2{p;q}')
monitor_width=$(echo "$monitor_info" | awk '{print $1}' | cut -d 'x' -f1)

## ? Update the width in the waybar config
sed -i "s/\"width\":.*/\"width\": $monitor_width,/" ~/.config/waybar/config

