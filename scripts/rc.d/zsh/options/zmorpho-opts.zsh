#!/usr/bin/env zsh

zstyle ':morpho' screen-saver cmatrix              # select screen saver "zmorpho"; available: zmorpho, zmandelbrot, zblank, pmorpho (this can also be a command, e.g. "cmatrix")
zstyle ':morpho' arguments '-C cyan -s -a -b -u 2' # ? args given to screen saver program(-s: every key press ends;)
zstyle ':morpho' delay 360                         # ? 6 mins before screen saver starts
zstyle ':morpho' check-interval 40                 # ? check every 300 seconds before running screen saver
