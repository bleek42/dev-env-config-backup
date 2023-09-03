#!/usr/bin/env bash

function scoop() {
	powershell -ex unrestricted scoop.ps1 "$@" && export -f scoop
}
