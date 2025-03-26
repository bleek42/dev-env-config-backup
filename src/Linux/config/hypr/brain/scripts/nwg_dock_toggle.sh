#!/usr/bin/env bash

a=$(pidof nwg-dock-hyprland)
if [[ $a ]]
then
    killall -9 nwg-dock-hyprland
    nwg-hud -m "nwg-dock-hyprland disabled"
else
    nwg-hud -m "nwg-dock-hyprland enabled"
    nwg-dock-hyprland -x -p "bottom"  -i 24 -mt 10 -mb 10 -ml 5 -f
fi
