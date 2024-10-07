#!/usr/bin/env sh

# speed up script and avoid language problems by using standard c
LC_ALL=C
LANG=C

# help
script=$(basename "$0")
help="$script [-h/--help] -- script to search and open man pages
  Usage:
    $script

  Examples:
    $script"

[ -n "$1" ] \
    && printf "%s\n" "$help" \
    && exit 0

select=$(man -k -l '' \
    | sort -fV \
    | fzf +s --query="^" \
        --preview-window "up:75%" \
        --preview "man {1}{2} 2>/dev/null" \
    | cut -d ' ' -f1,2 \
    | tr -d ' ' \
)

[ -n "$select" ] \
    && man "$select"
