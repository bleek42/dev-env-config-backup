#!/usr/bin/env zsh
## * Check for bugs such as null pointer references, unhandled exceptions, and more.
## * setopt ERR_EXIT

## * prompt style and colors based on Steve Losh's Prose theme:
## ? https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
## * vcs_info modifications from Bart Trojanowski's zsh prompt:
## ? http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
## * git untracked files modification from Brian Carper:
## ? https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

#use extended color palette if available

case "${TERM}" in
    (*256color|*rxvt*|*alacritty*|*kitty*|*foot*)
        # echo "256 color terminal"
        turquoise="%{${(%):-"%F{81}"}%}"
        red="%{${(%):-"%F{9}"}%}"
        orange="%{${(%):-"%F{166}"}%}"
        purple="%{${(%):-"%F{135}"}%}"
        hotpink="%{${(%):-"%F{161}"}%}"
        limegreen="%{${(%):-"%F{118}"}%}"
        gray="%{${(%):-"%F{246}"}%}"
        black="%{${(%):-"%F{0}"}%}"
    ;;
    *)
        turquoise="%{${(%):-"%F{cyan}"}%}"
        orange="%{${(%):-"%F{yellow}"}%}"
        purple="%{${(%):-"%F{magenta}"}%}"
        hotpink="%{${(%):-"%F{red}"}%}"
        limegreen="%{${(%):-"%F{green}"}%}"
        black="%{${(%):-"%F{black}"}%}"
    ;;
esac


autoload -Uz vcs_info
## * enable version control systems (VCS) you use
zstyle ':vcs_info:*' enable git svn

## * 'check-for-changes' can be really slow.
## * disable it, especially if you work with large repositories.
zstyle ':vcs_info:*:prompt:*' check-for-changes true

## ? set formats
## ! %b - branchname
## ! %u - unstagedstr (see below)
## ! %c - stagedstr (see below)
## ! %a - action (e.g. rebase-i)
## ! %R - repository path
## ! %S - path in the repository
PR_RST="%{${reset_color}%}"
FMT_BRANCH=" on ${purple}%b%u%c${PR_RST}"
FMT_ACTION=" performing a ${limegreen}%a${PR_RST}"
FMT_UNSTAGED="${orange} ●"
FMT_STAGED="${purple} ●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function blackarch_prompt_chpwd {
  PR_GIT_UPDATE=1
}

function blackarch_prompt_preexec {
  case "$2" in
        *git*|*svn*) PR_GIT_UPDATE=1
    ;;
  esac
}

function blackarch_prompt_precmd {
  (( PR_GIT_UPDATE )) || return

  ## * check for untracked files or updated submodules, since vcs_info doesn't
  if [[ -n "$(git ls-files --other --exclude-standard 2>/dev/null)" ]]; then
    PR_GIT_UPDATE=1
    FMT_BRANCH="${PM_RST} on ${turquoise}%b%u%c${hotpink} ●${PR_RST}"
  else
    FMT_BRANCH="${PM_RST} on ${turquoise}%b%u%c${PR_RST}"
  fi
  zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH}"

  vcs_info 'prompt'
  PR_GIT_UPDATE=
}

## * vcs_info running hooks
PR_GIT_UPDATE=1

autoload -U add-zsh-hook
add-zsh-hook chpwd blackarch_prompt_chpwd
add-zsh-hook precmd blackarch_prompt_precmd
add-zsh-hook preexec blackarch_prompt_preexec

## ? ruby prompt settings
ZSH_THEME_RUBY_PROMPT_PREFIX="with${red} "
ZSH_THEME_RUBY_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_RVM_PROMPT_OPTIONS="v g"

## ? virtualenv prompt settings
ZSH_THEME_VIRTUALENV_PREFIX=" with${turquoise} "
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

## ? git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="${yellow}%B on "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}${red}%B ✘ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="${limegreen}%B ✔ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED=true
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX="${yellow}("
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX="${yellow})%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" +"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR="${limegreen}"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" -"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR="${hotpink}"

setopt prompt_subst
## * PROMPT="${purple}%n%{$reset_color%} in ${limegreen}%~%{$reset_color%}\$(virtualenv_prompt_info)\$(ruby_prompt_info)\$vcs_info_msg_0_${orange} λ%{$reset_color%} "

PROMPT="${turquoise}%B[%b%f${limegreen}%n%f${purple}%B%b%f${limegreen}%m%f${turquoise}%B]-%b%f${turquoise}%B%b%f ${orange}󱉆%f ${gray}%~%f ${turquoise}%B%b%f
${limegreen}%Bλ%b%f ${turquoise}%B󰅂󰅂󰅂%b%f%{$reset_color%} "

RPROMPT="${turquoise}$(git_prompt_info)%f%{$reset_color%} ${purple}$(git_remote_status)%f%{$reset_color%}"

