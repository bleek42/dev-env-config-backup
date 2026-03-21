#!/usr/bin/env sh

## ? "Change keyboard layout in" "~/.config/hypr/hyprland.conf" " " \
# Set the width and height of the calendar window
keyhint_width=640
keyhint_height=640

# Get the screen width and height
screen_width=$(xrandr -q | grep -w Screen | sed 's/.*current //;s/,.*//' | awk '{print $1}')
screen_height=$(xrandr -q | grep -w Screen | sed 's/.*current //;s/,.*//' | awk '{print $3}')

# Calculate the x and y coordinates of the window
x=$(( (screen_width - keyhint_width) / 2 ))
y=$(( (screen_height - keyhint_height) / 2 ))
    # --center \

yad --title="Garuda Hyprland Keybindings" \
    --width="$keyhint_width" \
    --height="$keyhint_height" \
    --center \
    --fixed \
    --list \
    --no-buttons \
    --column=Key: \
    --column=Info: \
    --column=Cmd: \
    --timeout=120 \
    --timeout-indicator=right \
        "ESC" "close this app" "" "=" "modkey" "(set mod Mod4)" \
        "+Shift+g" "G-hyprland" "implement G-Hyprland" \
        "+enter/+t" "Terminal" "(foot)" \
        "" "Menu" "(wofi)" \
        "+d" "App Drawer" "(nwg-drawer)" \
        "+Shift+d" "Executable Launcher" "(nwgdmenu)" \
        "+o" "" "Open Broswer" \
        "+n" "" "Open Files" \
        "+q" "close focused app" "(kill)" \
        "+v" "clipboard manager" "(cliphist)" \
        "+r" "Resize windows" "(resize)" \
        "Print" "screenshot" "(grimblast)" \
        "Shift+Print" "screenshot region" "(grimblast)" \
        "+Print" "screenshot window" "(grimblast)" \
        "+Shift+e" "power-menu" "(wofi)" \
        "+Shift+c" "Change wallpaper" "(wpaperd)" \
        "+f" "Fullscreen" "Toggles to full screen" \
        "+Shift+f" "Fake fullscreen" "Behave full screen without full screen" \
        "+Shift+Spacebar" "Float" "Toggle windows to float" \
        "+p" "Dwindle effect" "pseudo" \
        "+Shift+p" "Dwindle effect" "toggle split" \
        "+i" "Calamares" "Install Garuda Hyprland" \
        "+" "" "" \
        "" "" "     Window closed in 60 sec."
