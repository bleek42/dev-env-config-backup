#!/usr/bin/env sh

## * /etc/X11/xinit/xinitrc
## * user xinitrc / xsession file
## * used by all X sessions started by xinit (startx)
## ? invoke global X session script
## ? start up file for lxqt desktop
## ? run with `emulate bash -c "source ~/.xinitrc"` from ZSH, drop 'emulate' if using other shells
## ? use with XRDP, XLaunch w/ RDP, tigerVNC, etc...

### ! need to have display defined - using 'localhost', 'hostname', get local ip or public w/ port forarding, etc.

[ -z "${DISPLAY}" ] && export DISPLAY='localhost':0


## ! check if in Windows Subsystem for Linux (WSL) by checking if var WSL_ENV array/string exists
if [ -n "$WSL_ENV" ]; then
  ### ! explicitly needed when using WSL
  unset WAYLAND_DISPLAY
  export GDK_SCALE=1
  export QT_SCALE_FACTOR=1
  export LIBGL_ALWAYS_INDIRECT=1
  export LIBGL_ALWAYS_SOFTWARE=true

fi

## ! Executed by startx (run your window manager from here)
userresources="${HOME}/.config/X11"
# usermodmap="${HOME}/.Xmodmap"
# sysresources=/etc/X11/xinit/.Xresources
# sysmodmap=/etc/X11/xinit/.Xmodmap
#   for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    # [ -x "$f" ] && source "$f"
#   done
#   unset f

if [ -d "$userresources" ]; then
    xrdb -merge "${userresources}/Xresources"
fi

unset userresources

# case "${x-session}" in
#     pattern)
#         command ...
#         ;;
#     *)
#         command ...
#         ;;
# esac
i3 all
# exec x-session-manager
