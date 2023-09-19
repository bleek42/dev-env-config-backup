#!/usr/bin/env bash

export WAYLAND_DISPLAY=
export LIBGL_ALWAYS_INDIRECT=1
# export GTK_THEME=''
export GDK_SCALE=1
export QT_SCALE_FACTOR=1

exec xfce4-session
