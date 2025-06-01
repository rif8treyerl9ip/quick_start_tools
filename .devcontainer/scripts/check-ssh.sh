#!/bin/bash

# =======================================================
# SSH Configuration Check
# =======================================================

log() {
    echo -e "\033[1;34m[SSH]\033[0m $1"
}

if ssh-add -l &>/dev/null; then
    log "\033[1;32mssh-agent: OK\033[0m"
    log "\033[1;32mRegistered SSH Keys ✅:\033[0m"
    ssh-add -l
else
    log "\033[1;31mFAILED\033[0m"
    log "\033[1;31mError: No SSH keys registered in ssh-agent\033[0m"
fi

github_result=$(ssh -T git@github.com 2>&1)
if echo "$github_result" | grep -q "successfully authenticated"; then
    log "\033[1;32mGitHub Authentication Test ✅\033[0m"
    log "$github_result"
else
    log "\033[1;31mGitHub Authentication Test: ❌\033[0m"
    log "\033[1;31mError: $github_result\033[0m"
fi

log "\033[1;34mSSH check completed\033[0m"