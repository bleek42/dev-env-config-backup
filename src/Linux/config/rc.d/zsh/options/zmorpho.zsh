#!/usr/bin/env zsh

zstyle ':morpho' screen-saver cmatrix              # select screen saver "zmorpho"; available: zmorpho, zmandelbrot, zblank, pmorpho (this can also be a command, e.g. "cmatrix")
zstyle ':morpho' arguments '-C cyan -s -a -b -u 2' # ? args given to screen saver program(-s: every key press ends;)
zstyle ':morpho' delay 600                         # ? 10 mins before screen saver starts
zstyle ':morpho' check-interval 60                 # ? check every 60 seconds before running screen saver
