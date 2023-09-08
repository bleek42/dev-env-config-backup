#!/usr/bin/env bash

test -f ~/.profile && emulate sh -c 'source ~/.profile'
test -f ~/.bashrc && source ~/.zshrc
