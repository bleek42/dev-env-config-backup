#!/usr/bin/env bash

##?##################################################################################
## ? Check if each of the given commands is available in the PATH.				   ##
## ? All commands must be available, otherwise the function will return with a	   ##
## ? non-zero exit status.														   ##
##?###################################################################################
## * The function takes one or more command names as arguments. It checks each
## * command by running `command -v "$cmd" >/dev/null 2>&1`. This command checks
## * whether the given command is available in the PATH, and it returns with a
## * zero exit status if the command is available, or a non-zero exit status
## * otherwise.
## *
## * The redirections `>/dev/null 2>&1` are used to suppress the output of the
## * `command -v` invocation. The output of `command -v` is not needed, and it
## * would be confusing to print it, so it is redirected to /dev/null. The
## * stderr is also redirected to /dev/null to avoid printing any error messages
## * if the command is not available.
## *
## * The function returns with a zero exit status if all commands are available,
## * or a non-zero exit status if any command is not available.
function has_cmd() {
    for cmd in "$@"; do
        command -v "$cmd" >/dev/null 2>&1
    done
}

alias -g hascmd='has_cmd'

############################################################
# Take all host sections in .ssh/config and offer them for
# completion as hosts (e.g. for ssh, rsync, scp and the like)
# Filter out wildcard host sections.
# _ssh_configfile="$HOME/.ssh/config"

# Get the filename to store/lookup the environment from
ssh_env_cache="${HOME}/.ssh/${SHORT_HOST:-$HOST}.env"

function ssh_start_agent() {
    # Check if ssh-agent is already running
    if [ -f "$ssh_env_cache" ]; then
        source "$ssh_env_cache" >/dev/null

        # Test if $SSH_AUTH_SOCK is visible
        if [ -n "$ZSH_VERSION" ]; then
            zmodload zsh/net/socket
            if [[ -S "$SSH_AUTH_SOCK" ]] && zsocket "$SSH_AUTH_SOCK" 2>/dev/null; then
                return 0
            fi
        else
            if [[ -S "$SSH_AUTH_SOCK" ]]; then
                return 0
            fi
        fi
    fi

    if [[ ! -d "$HOME/.ssh" ]]; then
        echo "[ERROR]: ssh-agent requires $HOME/.ssh directory..!"
        return 1
    fi

    # Set a maximum lifetime for identities added to ssh-agent
    local lifetime=600
    #   zstyle -s :omz:plugins:ssh-agent lifetime lifetime

    # start ssh-agent and setup environment
    echo >&2 "Starting ssh-agent ..."
    ssh-agent -s ${lifetime:+-t} "${lifetime}" | sed '/^echo/d' >| "$ssh_env_cache"
    chmod 600 "$ssh_env_cache"
    source "$ssh_env_cache" >/dev/null
}

# function ssh_add_ids() {
#   local id file line sig lines
#   local -a ids loaded_sigs loaded_ids not_loaded
# #   zstyle -a :omz:plugins:ssh-agent identities identities

#   # check for .ssh folder presence
#   if [[ ! -d "$HOME/.ssh" ]]; then
#     return
#   fi

#     for file in "${HOME}"/.ssh/id_*; do
#         [[ $file != *.pub ]] && ids+=("$file")
#     done
#   # add default keys if no identities were set up via zstyle
#   # this is to mimic the call to ssh-add with no identities
# #   if [[ ${#ids_arr} -eq 0 ]]; then
# #     # key list found on `ssh-add` man page's DESCRIPTION section
# #     for id in id_rsa id_dsa id_ecdsa id_ed25519 id_ed25519_sk identity; do
# #       # check if file exists
# #       [[ -f "$HOME/.ssh/$id" ]] && identities+=($id)
# #     done
# #   fi

#   # get list of loaded identities' signatures and filenames
#   if lines=($(ssh-add -l 2>/dev/null)); then
#     for line in "${lines[@]}"; do
#       if (( ${#line} >= 3 )); then
#         loaded_sigs+=${line[2]}
#         loaded_ids+=${line[3]}
#       fi
#     done
# fi
# #   if lines=$(ssh-add -l); then
# #     for line in ${(f)lines}; do
# #       loaded_sigs+=${${(z)line}[2]}
# #       loaded_ids+=${${(z)line}[3]}
# #     done
# #   fi
# # /******  e0b2f206-68f9-43c2-abfe-2b4b6db180e3  *******/

#   # add identities if not already loaded
#   for id in "${ids[@]}"; do
#     # if id is an absolute path, make file equal to id
#     [[ "$id" = /* ]] && file="$id" || file="$HOME/.ssh/$id"
#     # check for filename match, otherwise try for signature match
#     if [[ -f $file && ${loaded_ids[(I)$file]} -le 0 ]]; then
#       sig="$(ssh-keygen -lf "$file" | awk '{print $2}')"
#       [[ ${loaded_sigs[(I)$sig]} -le 0 ]] && not_loaded+=("$file")
#     fi
#   done

#   # abort if no identities need to be loaded
#   if [[ ${#not_loaded} -eq 0 ]]; then
#     return
#   fi

# #   # pass extra arguments to ssh-add
# #   local args
# #   zstyle -a :omz:plugins:ssh-agent ssh-add-args args

# #   # if ssh-agent quiet mode, pass -q to ssh-add
# #   zstyle -t :omz:plugins:ssh-agent quiet && args=(-q $args)

#   # use user specified helper to ask for password (ksshaskpass, etc)
# #   local helper
# #   zstyle -s :omz:plugins:ssh-agent helper helper

# #   if [[ -n "$helper" ]]; then
# #     if [[ -z "${commands[$helper]}" ]]; then
# #       echo >&2 "ssh-agent: the helper '$helper' has not been found."
# #     else
# #       SSH_ASKPASS="$helper" ssh-add "${args[@]}" "${^not_loaded}" < /dev/null
# #       return $?
# #     fi
# #   fi

#   ssh-add "${args[@]}" "${^not_loaded}"
# }

###?#########################################################
## ? Remove host key from known hosts based on a host      ##
## ?  section name from .ssh/config                        ##
###?#########################################################
function ssh_rm_host_key() {
    local ssh_host="$1"
    local ssh_config_file="$HOME/.ssh/config"

    if [[ -z "$ssh_host" ]]; then
        echo "ERROR: must provide name of a valid SSH host as an argument..!"
        return 1
    fi

    ssh-keygen -R "$(grep -A10 "$ssh_host" "$ssh_config_file" | grep -i HostName | head -n 1 | awk '{print $2}')"
}
compctl -k hosts ssh_rm_host_key

###?#########################################################
## ? Load SSH key into agent                               ##
###?#########################################################
function ssh_load_key() {
    local key="$1"

    if [[ -z "$key" ]]; then
        echo "ERROR: must provide path to SSH key file as an argument..!"
        return 1
    fi

    local key_file="$HOME/.ssh/$key"
    # shellcheck disable=SC2155
    local key_sig="$(ssh-keygen -l -f "$key_file")"
    if (! ssh-add -l | grep -q "$key_sig"); then
        ssh-add "$key_file"
    fi
}

###?#########################################################
## ? Remove SSH key from agent                             ##
###?#########################################################
function ssh_unload_key() {
    local key="$1"

    if [[ -z "$key" ]]; then
        echo "ERROR: must provide path to SSH key file as an argument..!"
        return 1
    fi

    local key_file="$HOME/.ssh/$key"
    # shellcheck disable=SC2155
    local key_sig="$(ssh-keygen -l -f "$key_file")"
    if (ssh-add -l | grep -q "$key_sig"); then
        ssh-add -d "$key_file"
    fi
}

alias -g sshagentstart='ssh_agent_start'
alias -g sshrmkey='ssh_rm_host_key'
alias -g sshloadkey='ssh_load_key'
alias -g sshunloadkey='ssh_unload_key'

###?##################################################################################
## ? Fetch system information.												        ##
###?##################################################################################
## * If the current shell is connected to /dev/pts/0 and the terminal is not
## * VSCode, then use the first available system information fetching command in
## * the following order: fastfetch, neofetch, pfetch. If none of these commands is
## * available, do nothing.
function fetch_sysinfo() {
    if [[ $(tty -s) == /dev/pts/0 && -z $TERM_PROGRAM || ! $TERM_PROGRAM =~ ^vs ]]; then
        for cmd in fastfetch neofetch pfetch; do
            if command -v "$cmd" >/dev/null 2>&1; then
                "$cmd"
                return
            fi
        done
        echo "ERROR: No system information fetcher command found in PATH..!" >&2
        return 1
    fi
}

alias -g fetchsysinfo='fetch_sysinfo'
alias -g hascmd='has_cmd'

if command -v batpipe >/dev/null 2>&1; then
    eval "$(batpipe)"
fi
