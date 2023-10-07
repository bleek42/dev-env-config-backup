#!/usr/bin/env zsh

# configure key keybindings
bindkey -e # emacs key bindings
zmodload zsh/terminfo
typeset -A key


key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[Backspace]=${terminfo[kbs]}
key[ShiftTab]="${terminfo[kcbt]}"
# man 5 user_caps
key[CtrlLeft]=${terminfo[kLFT5]}
key[CtrlRight]=${terminfo[kRIT5]}
# Setup keys accordingly
[[ -n "${key[Up]}"        ]] && bindkey -M main "${key[Up]}"         history-substring-search-up
[[ -n "${key[Down]}"      ]] && bindkey -M main "${key[Down]}"       history-substring-search-down
[[ -n "${key[Home]}"      ]] && bindkey "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}"    ]] && bindkey "${key[Delete]}"     delete-char
[[ -n "${key[Left]}"      ]] && bindkey "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}"  backward-delete-char
[[ -n "${key[ShiftTab]}"  ]] && bindkey "${key[ShiftTab]}"   reverse-menu-complete
[[ -n "${key[CtrlLeft]}"  ]] && bindkey "${key[CtrlLeft]}"   backward-word
[[ -n "${key[CtrlRight]}" ]] && bindkey "${key[CtrlRight]}"  forward-word
# # Make sure that the terminal is in application mode when zle is active, since
# # only then values from $terminfo are valid
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -U add-zle-hook-widget

  function zle_application_mode_start () {
    # arguments are accessible through $1, $2,...
      echo ti smkx
  }


    function zle_application_mode_stop () {
      echo ti rmkx
    }

    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
