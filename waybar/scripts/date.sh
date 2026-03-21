#!/usr/bin/env bash

# Set the width and height of the calendar window
calendar_width=400
calendar_height=200

# Get the screen width and height
screen_width=$(xrandr -q | grep -w Screen | sed 's/.*current //;s/,.*//' | awk '{print $1}')
screen_height=$(xrandr -q | grep -w Screen | sed 's/.*current //;s/,.*//' | awk '{print $3}')

# Calculate the x and y coordinates of the window
x=$(( (screen_width - calendar_width) / 2 ))
y=$(( (screen_height - calendar_height) / 2 ))

# Display the calendar
yad \
    --title="Calendar" \
    --calendar \
    --fixed \
    --width="$calendar_width" \
    --height="$calendar_height" \
    --geometry="+$x+$y"

