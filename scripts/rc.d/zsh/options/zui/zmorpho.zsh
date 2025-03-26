#!/usr/bin/env zsh

## ? check if "cmatrix" command in path and use it as terminal screen-saver
## ? built-in scree-savers commands/functions: zmorpho, zmandelbrot, zblank, pmorpho
if (( ${+commands[cmatrix]} )); then
    zstyle ':morpho' screen-saver cmatrix && \
    ## * args given to screen saver program(-s: every key press ends;) \\
    zstyle ':morpho' arguments '-C cyan -s -a -b -u 2'
fi

zstyle ':morpho' delay 600                   ## * 10 mins before screen saver starts
zstyle ':morpho' check-interval 60           ## * check every 60 seconds before running screen saver
