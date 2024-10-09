#!/usr/bin/env bash

# Check if ssh_agent.env file exists, if not create it

# Function to load the ssh agent environment variables
ssh_agent_load_env() {
    ssh_env="${HOME}"/.ssh/ssh_agent.env
    if test -f "$ssh_env"; then
        source "$ssh_env" >/dev/null 2>&1
    else
        touch "$ssh_env"
    fi

}

# Function to start the ssh agent and load the environment variables
ssh_agent_start() {
    # Create the ssh agent environment variables file
    (
        umask 076
        ssh-agent >"${HOME}"/.ssh/ssh_agent.env
    )

    # Load the ssh agent environment variables
    ssh_agent_load_env

    # Add the SSH keys to the agent
    for key in "${HOME}"/.ssh/id_*; do
        if grep -q PRIVATE "$key"; then
            ssh-add "$key"
        fi
    done
}

# Check if ssh_agent.env file exists, if not start the ssh agent
if test -f "${HOME}"/.ssh/ssh_agent.env; then
    ssh_agent_load_env
else
    ssh_agent_start
fi

# Export the ssh_agent.env path
# export GIT_INSTALL_ROOT="${PROGRAMFILES:-'/c/Program Files'}"Git
# export GIT_EXEC_PATH=/mingw64/bin

test -f "${HOME}/.bashrc" && \
    source "${HOME}/.bashrc"

# later make your own bash scripts & command aliases, put them in ~/.config/bash, make sure they all end in file type .sh or change the below code: will be sourced & applied on every terminal/bash sesh
if test -d "${XDG_CONFIG_HOME}"/bash/functions; then
    for src in "${XDG_CONFIG_HOME}"/bash/functions/*.sh; do
        # shellcheck disable=SC1090
        source "$src"
    done
    unset src
fi

# if command -v node >/dev/null 2>&1; then
#     NODE_PATH="${NODE_PATH:=$(which node)}"
#     test -n "$NODE_PATH" && export NODE_PATH
# fi

# if command -v pnpm >/dev/null 2>&1; then
#     PNPM_HOME="$(which pnpm)"
#     test -n "$PNPM_HOME" && export PNPM_HOME
# fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(
        direnv hook bash && direnv allow
    )"
fi

# test -n "$WT_SESSION" && export TERM_PROGRAM="wterm"

tty_current="$(tty)"

# * display system info with git-bash-specific config
# ? only when launching your 1st & 2nd interactive terminal/bash shell sessions
# ? can track sessions with checking for existence of incremented file written at '/dev/cons<0|1'
# ? never if session is in integrated VS Code terminal
shopt -s nocaseglob
if [[ $TERM_PROGRAM != *vscode* ]] && test "$tty_current" -ef '/dev/cons0'; then
    fastfetch -c "${HOME}"/.config/fastfetch/git-bash.jsonc
fi

shopt -u nocaseglob

if command -v oh-my-posh >/dev/null 2>&1; then
    case "$TERM_PROGRAM" in
    *windows-terminal* | wt*)
        eval "$(oh-my-posh init bash --config ${HOME}/.bleek-lambda.omp.json)"
        ;;
    *)
        eval "$(oh-my-posh init bash --config ${POSH_THEMES_PATH}/stelbent.minimal.omp.json)"
        ;;
    esac

fi
