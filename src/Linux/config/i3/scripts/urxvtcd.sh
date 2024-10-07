#!/usr/bin/env bash

test -d /tmp/urxvt || mkdir -p /tmp/urxvt
export RXVT_SOCKET="/tmp/urxvt/urxvtd-$HOST"

urxvtc "$@"
if [ $? -eq 2 ]; then
   urxvtd -q -o -f
   urxvtc "$@"
fi
