#!/usr/bin/env bash

## ? ~/.Xsession start up file for i3 window manager
# meant to be run with `bash -c "~/.Xsession"` when running from XRDP, Windows XLaunch & RDP, tigerVNC, etc.

# explicitly needed when launching with bash -c from Windows
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY="127.0.0.1:5901"
xrandr --dpi 279
exec i3 -d all
