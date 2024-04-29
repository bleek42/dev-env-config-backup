#!/usr/bin/env zsh

### * ZSH KEYBINDINGS ------------------------------------------------------------- #
### * http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html                   #
### * http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins      #
### * http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets  #
### * ###############################################################################
# to add other keys to this hash, see: man 5 terminfo
zmodload zsh/terminfo
typeset -gA termkeys
# setup key accordingly
# [[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
# [[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
# [[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
# [[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
# [[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         _histdb-isearch-up
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       _histdb-isearch-up
# [[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
# [[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
# [[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
# [[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
# [[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

### ? configure key keybindings
# +---------------------------------+
# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
    termkeys[PageUp]="${terminfo[kpp]}"
  bindkey -M emacs "${termkeys[PageUp]}" up-line-or-history
  bindkey -M viins "${termkeys[PageUp]}" up-line-or-history
  bindkey -M vicmd "${termkeys[PageUp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
    termkeys[PageDown]="${terminfo[knp]}"
  bindkey -M emacs "${termkeys[PageDown]}" down-line-or-history
  bindkey -M viins "${termkeys[PageDown]}" down-line-or-history
  bindkey -M vicmd "${termkeys[PageDown]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
# autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M emacs "^[[A" _histdb-search-up
bindkey -M viins "^[[A" _histdb-search-up
bindkey -M vicmd "^[[A" _histdb-search-up

if [[ -n "${terminfo[kcuu1]}" ]]; then
    termkeys[Up]="${terminfo[kcuu1]}"
  bindkey -M emacs "${termkeys[Up]}" _histdb-isearch-up
  bindkey -M viins "${termkeys[Up]}" _histdb-isearch-up
  bindkey -M vicmd "${termkeys[Up]}" _histdb-isearch-up
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M emacs "^[[B" _histdb-isearch-down
bindkey -M viins "^[[B" _histdb-isearch-down
bindkey -M vicmd "^[[B" _histdb-isearch-down

if [[ -n "${terminfo[kcud1]}" ]]; then
termkeys[Down]="${terminfo[kcud1]}"
  bindkey -M emacs "${termkeys[Down]}" _histdb-isearch-down
  bindkey -M viins "${termkeys[Down]}" _histdb-isearch-down
  bindkey -M vicmd "${termkeys[Down]}" _histdb-isearch-down
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    termkeys[Home]="${terminfo[khome]}"
  bindkey -M emacs "${termkeys[Home]}" beginning-of-line
  bindkey -M viins "${termkeys[Home]}" beginning-of-line
  bindkey -M vicmd "${termkeys[Home]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    termkeys[End]="${terminfo[kend]}"
  bindkey -M emacs "${termkeys[End]}"  end-of-line
  bindkey -M viins "${termkeys[End]}"  end-of-line
  bindkey -M vicmd "${termkeys[End]}"  end-of-line
fi

# termkeys[Insert]="${terminfo[kich1]}"
# termkeys[Backspace]="${terminfo[kbs]}"
# termkeys[Left]="${terminfo[kcub1]}"
# termkeys[Right]="${terminfo[kcuf1]}"

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
termkeys[Shift-Tab]="${terminfo[kcbt]}"
  bindkey -M emacs "${termkeys[Shift-Tab]}" reverse-menu-complete
  bindkey -M viins "${termkeys[Shift-Tab]}" reverse-menu-complete
  bindkey -M vicmd "${termkeys[Shift-Tab]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
termkeys[Delete]="${terminfo[kdch1]}"
  bindkey -M emacs "${termkeys[Delete]}" delete-char
  bindkey -M viins "${termkeys[Delete]}" delete-char
  bindkey -M vicmd "${termkeys[Delete]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


# | Simply mapping escape sequences |
# # +---------------------------------+

# 'bindkey' '-s' '^[OM'    '^M'
# 'bindkey' '-s' '^[Ok'    '+'
# 'bindkey' '-s' '^[Om'    '-'
# 'bindkey' '-s' '^[Oj'    '*'
# 'bindkey' '-s' '^[Oo'    '/'
# 'bindkey' '-s' '^[OX'    '='
# 'bindkey' '-s' '^[OA'    '^[[A'
# 'bindkey' '-s' '^[OB'    '^[[B'
# 'bindkey' '-s' '^[OD'    '^[[D'
# 'bindkey' '-s' '^[OC'    '^[[C'
# 'bindkey' '-s' '^[OH'    '^[[H'
# 'bindkey' '-s' '^[[1~'   '^[[H'
# 'bindkey' '-s' '^[[7~'   '^[[H'
# 'bindkey' '-s' '^[OF'    '^[[F'
# 'bindkey' '-s' '^[[4~'   '^[[F'
# 'bindkey' '-s' '^[[8~'   '^[[F'
# 'bindkey' '-s' '^[[3\^'  '^[[3;5~'
# 'bindkey' '-s' '^[^[[3~' '^[[3;3~'
# 'bindkey' '-s' '^[[1;9C' '^[[1;3C'
# 'bindkey' '-s' '^[^[[C'  '^[[1;3C'
# 'bindkey' '-s' '^[[1;9D' '^[[1;3D'
# 'bindkey' '-s' '^[^[[D'  '^[[1;3D'
# 'bindkey' '-s' '^[Od'    '^[[1;5D'
# 'bindkey' '-s' '^[Oc'    '^[[1;5C'

# create a zkbd compatible hash;
typeset -gA keys=(
    Up                   '^[[A'
    Down                 '^[[B'
    Right                '^[[C'
    Left                 '^[[D'
    Home                 '^[[H'
    End                  '^[[F'
    Insert               '^[[2~'
    Delete               '^[[3~'
    PageUp               '^[[5~'
    PageDown             '^[[6~'
    Backspace            '^?'

    Shift+Up             '^[[1;2A'
    Shift+Down           '^[[1;2B'
    Shift+Right          '^[[1;2C'
    Shift+Left           '^[[1;2D'
    Shift+End            '^[[1;2F'
    Shift+Home           '^[[1;2H'
    Shift+Insert         '^[[2;2~'
    Shift+Delete         '^[[3;2~'
    Shift+PageUp         '^[[5;2~'
    Shift+PageDown       '^[[6;2~'
    Shift+Backspace      '^?'
    Shift+Tab            '^[[Z'

    Alt+Up               '^[[1;3A'
    Alt+Down             '^[[1;3B'
    Alt+Right            '^[[1;3C'
    Alt+Left             '^[[1;3D'
    Alt+End              '^[[1;3F'
    Alt+Home             '^[[1;3H'
    Alt+Insert           '^[[2;3~'
    Alt+Delete           '^[[3;3~'
    Alt+PageUp           '^[[5;3~'
    Alt+PageDown         '^[[6;3~'
    Alt+Backspace        '^[^?'

    Alt+Shift+Up         '^[[1;4A'
    Alt+Shift+Down       '^[[1;4B'
    Alt+Shift+Right      '^[[1;4C'
    Alt+Shift+Left       '^[[1;4D'
    Alt+Shift+End        '^[[1;4F'
    Alt+Shift+Home       '^[[1;4H'
    Alt+Shift+Insert     '^[[2;4~'
    Alt+Shift+Delete     '^[[3;4~'
    Alt+Shift+PageUp     '^[[5;4~'
    Alt+Shift+PageDown   '^[[6;4~'
    Alt+Shift+Backspace  '^[^H'

    Ctrl+Up              '^[[1;5A'
    Ctrl+Down            '^[[1;5B'
    Ctrl+Right           '^[[1;5C'
    Ctrl+Left            '^[[1;5D'
    Ctrl+Home            '^[[1;5H'
    Ctrl+End             '^[[1;5F'
    Ctrl+Insert          '^[[2;5~'
    Ctrl+Delete          '^[[3;5~'
    Ctrl+PageUp          '^[[5;5~'
    Ctrl+PageDown        '^[[6;5~'
    Ctrl+Backspace       '^H'

    Ctrl+Shift+Up        '^[[1;6A'
    Ctrl+Shift+Down      '^[[1;6B'
    Ctrl+Shift+Right     '^[[1;6C'
    Ctrl+Shift+Left      '^[[1;6D'
    Ctrl+Shift+Home      '^[[1;6H'
    Ctrl+Shift+End       '^[[1;6F'
    Ctrl+Shift+Insert    '^[[2;6~'
    Ctrl+Shift+Delete    '^[[3;6~'
    Ctrl+Shift+PageUp    '^[[5;6~'
    Ctrl+Shift+PageDown  '^[[6;6~'
    Ctrl+Shift+Backspace '^?'

    Ctrl+Alt+Up          '^[[1;7A'
    Ctrl+Alt+Down        '^[[1;7B'
    Ctrl+Alt+Right       '^[[1;7C'
    Ctrl+Alt+Left        '^[[1;7D'
    Ctrl+Alt+Home        '^[[1;7H'
    Ctrl+Alt+End         '^[[1;7F'
    Ctrl+Alt+Insert      '^[[2;7~'
    Ctrl+Alt+Delete      '^[[3;7~'
    Ctrl+Alt+PageUp      '^[[5;7~'
    Ctrl+Alt+PageDown    '^[[6;7~'
    Ctrl+Alt+Backspace   '^[^H'

    Ctrl+Alt+Shift+Up        '^[[1;8A'
    Ctrl+Alt+Shift+Down      '^[[1;8B'
    Ctrl+Alt+Shift+Right     '^[[1;8C'
    Ctrl+Alt+Shift+Left      '^[[1;8D'
    Ctrl+Alt+Shift+Home      '^[[1;8H'
    Ctrl+Alt+Shift+End       '^[[1;8F'
    Ctrl+Alt+Shift+Insert    '^[[2;8~'
    Ctrl+Alt+Shift+Delete    '^[[3;8~'
    Ctrl+Alt+Shift+PageUp    '^[[5;8~'
    Ctrl+Alt+Shift+PageDown  '^[[6;8~'
    Ctrl+Alt+Shift+Backspace '^?'
)

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^z' fancy-ctrl-z
bindkey '^Xz' fancy-ctrl-z

bindkey '^a' alias-expension
bindkey '^Xa' alias-expension

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

# consider emacs keybindings:

#bindkey -e  ## emacs key bindings
#
#bindkey '^[[A' up-line-or-search
#bindkey '^[[B' down-line-or-search
#bindkey '^[^[[C' emacs-forward-word
#bindkey '^[^[[D' emacs-backward-word
#
#bindkey -s '^X^Z' '%-^M'
#bindkey '^[e' expand-cmd-path
#bindkey '^[^I' reverse-menu-complete
#bindkey '^X^N' accept-and-infer-next-history
#bindkey '^W' kill-region
#bindkey '^I' complete-word
## Fix weird sequence that rxvt produces
#bindkey -s '^[[Z' '\t'
#
# [[ -n "${key[Ctrl-z]}" ]] && bindkey -- "${key[Ctrl-z]}" fancy-ctrl-z

# ### ? should this be in keybindings?
# bindkey -M menuselect '^o' accept-and-infer-next-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then

	autoload -Uz add-zle-hook-widget

	function zle_application_mode_start {
        echoti smkx
    }

	function zle_application_mode_stop {
        echoti rmkx
    }

	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


if [[ ! $(command -v fzf) && ${COMPLETION_WAITING_DOTS:-false} != false ]]; then

  expand-or-complete-with-dots() {
    # use $COMPLETION_WAITING_DOTS either as toggle or as the sequence to show
    [[ $COMPLETION_WAITING_DOTS = true ]] && COMPLETION_WAITING_DOTS="%F{red}…%f"
    # turn off line wrapping and print prompt-expanded "dot" sequence
    printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots

  # Set the function as the default tab completion widget
  bindkey -M emacs "^I" expand-or-complete-with-dots
  bindkey -M viins "^I" expand-or-complete-with-dots
  bindkey -M vicmd "^I" expand-or-complete-with-dots
fi
