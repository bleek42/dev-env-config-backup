# typeset -Ag HSMW_HIGHLIGHT_STYLES
# HSMW_HIGHLIGHT_STYLES[path]="fg=cyan"
# HSMW_HIGHLIGHT_STYLES[commandseparator]="fg=241,bg=17"
# HSMW_HIGHLIGHT_STYLES[single-hyphen-option]="fg=green"
# HSMW_HIGHLIGHT_STYLES[double-hyphen-option]="fg=green"

zstyle ':plugin:history-search-multi-word:' page-size 8
zstyle ':plugin:history-search-multi-word:' reset-prompt-protect 1
zstyle ':plugin:history-search-multi-word:' synhl yes          # Whether to perform syntax highlighting (default true)
zstyle ':plugin:history-search-multi-word:' active underline   # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ':plugin:history-search-multi-word:' check-paths yes    # Whether to check paths for existence and mark with magenta (default true)
zstyle ':plugin:history-search-multi-word:' clear-on-cancel no # Whether pressing Ctrl-C or ESC should clear entered query
