#!/usr/bin/env zsh

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=024'

typeset -ga ZSH_AUTOSUGGEST_STRATEGY ZSH_AUTOSUGGEST_CLEAR_WIDGETS
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste-magic bracketed-url-magic)

(( ${+functions[autopair-init]} )) && ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(autopair-insert $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)
