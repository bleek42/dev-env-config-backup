#!/usr/bin/env sh

swayidle -w \
    timeout 300 'temp="$(brightnessctl g)"; brightnessctl set "$((temp / 2))"' \
    resume 'temp="$(brightnessctl g)"; brightnessctl set "$((temp * 2))"' \
    timeout 600 'gtklock & sleep 2; hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    timeout 1500 'systemctl suspend'
