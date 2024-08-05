#!/usr/bin/env zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste-magic bracketed-url-magic)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=024'

[[ -n $(type autopair-init) ]] && ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)

# if [[ -n $(type histdb) ]] && [[ -f "${ZI[CONFIG_DIR]}/options/history/histdb_all.zsh" ]]; then
#     source "${ZI[CONFIG_DIR]}/options/history/histdb_all.zsh"
#     ZSH_AUTOSUGGEST_STRATEGY=(histdb_all $ZSH_AUTOSUGGEST_STRATEGY)
# fi
