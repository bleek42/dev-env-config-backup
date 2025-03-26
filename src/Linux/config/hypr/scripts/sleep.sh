#!/usr/bin/env sh

swayidle -w \
    timeout 180 'temp="$(brightnessctl g)"; brightnessctl set "$((temp / 2))"' \
    resume 'temp="$(brightnessctl g)"; brightnessctl set "$((temp * 2))"' \
    timeout 300 'gtklock & sleep 1 && hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    timeout 600 'systemctl suspend'
