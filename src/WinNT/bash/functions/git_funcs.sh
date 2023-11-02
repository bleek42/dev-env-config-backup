#!/usr/bin/env bash

# ═══════════════════════════════════════
# WRAPPER FUNCTION FOR GH CLI
# ═══════════════════════════════════════

# list up to 100 of your remote repositories on GitHub
# function gh_repo_100() {
# 	eval "$(gh repo list {$1})"
# }

# ═══════════════════════════════════════
# GIT BRANCH MANAGEMENT
# ═══════════════════════════════════════
# Return a pretty-formatted string of the current git branch, if it exists
function gitbranch() {
	git rev-parse --abbrev-ref HEAD 2>/dev/null 1>/dev/null
	if [[ "$?" -eq "0" ]]; then
		str=" $(git rev-parse --abbrev-ref HEAD | tr -d '$' | tr -d '`')"
		echo " ${str}"
	fi
}
