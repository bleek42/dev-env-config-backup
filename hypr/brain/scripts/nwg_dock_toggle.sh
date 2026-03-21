#!/usr/bin/env bash

nwg_dock_pid=$(pidof nwg-dock-hyprland)
if [[ $nwg_dock_pid ]]
then
    killall -9 nwg-dock-hyprland
    nwg-hud -m "nwg-dock-hyprland disabled"
else
    nwg-hud -m "nwg-dock-hyprland enabled"
    nwg-dock-hyprland -x -i 40 -mt 4 -mb 4 -ml 2 -mr 2 -f
fi
