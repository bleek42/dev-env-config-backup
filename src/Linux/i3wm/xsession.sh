#!/usr/bin/env bash

## ? ~/.Xsession start up file for xfce4 desktop
## ? run with `emulate bash -c "source ~/.Xsession"` from ZSH, drop 'emulate' if using other shells
## ? use with XRDP, XLaunch w/ RDP, tigerVNC, etc...

# ! Executed by startx (run your window manager from here)
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# ! check if in Windows Subsystem for Linux (WSL) by checking if var WSL_ENV array/string exists
if [ -e "$WSL_ENV" ]; then
  # ! explicitly needed when using WSL
  unset WAYLAND_DISPLAY
  export LIBGL_ALWAYS_INDIRECT=1
  export GDK_SCALE=1
  export QT_SCALE_FACTOR=1
  # export GTK_THEME=''
  # xrandr --dpi 279
fi

## ! need to have display defined - using 'localhost', 'hostname', get local ip or public w/ port forarding, etc.
if [ -z "$DISPLAY" ]; then
  export DISPLAY=:0
fi

exec i3 -d all &
