#!/usr/bin/env bash

if pgrep -x "waybar" >/dev/null; then
    if command -v nwg-hud >/dev/null; then
        nwg-hud -m "Restarting Waybar process..."
    fi

    pkill -x waybar
    # * Wait for waybar to exit
    while pgrep -x "waybar" >/dev/null; do sleep 0.1; done
fi

if command -v systemctl >/dev/null && systemctl --user list-units >/dev/null 2>&1; then

    systemctl restart --user hyprshell.service 2>/dev/null || \
        systemctl enable --user --now waybar.service 2>/dev/null || \
         systemd-run -q -r --no-block \
                        --user --unit=waybar-run \
                        --description="man:waybar(5)" \
                        --slice=background-graphical "$(command -v waybar)"

else
    waybar &
fi
