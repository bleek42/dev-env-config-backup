#!/usr/bin/env bash

function meowlol() {
    meow -s 20 <"$1" | nl # arguments are accessible through $1, $2,...
}

