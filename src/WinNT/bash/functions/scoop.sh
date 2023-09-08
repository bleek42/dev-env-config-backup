#!/usr/bin/env bash

function scoop() {
    pwsh -ex unrestricted scoop.ps1 "$@" && export -f scoop
}
