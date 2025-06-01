#!/bin/bash

# =======================================================
# Aliases and Functions Setup
# =======================================================
# カスタムエイリアスと関数を.zshrcに追加

set -e

log() {
    echo "[ALIASES] $1"
}

log "Setting up aliases and functions..."

# .zshrcにエイリアスセクションを追加
cat << 'EOF' >> ~/.zshrc

# =======================================================
# Custom Aliases and Functions
# =======================================================

# Docker Container Management Function (Modular Version)
dexec() {
    if [ $# -gt 0 ]; then
        local container_id="$1"
        echo "Executing docker exec -it $container_id bash..."
        docker exec -it "$container_id" bash
        return
    fi
    # Interactive mode when no arguments are provided
    echo "List of running Docker containers:"
    echo "================================"
    docker ps
    echo "================================"
    echo -n "Enter the ID of the container you want to connect to: "
    read container_id
    if [ -n "$container_id" ]; then
        echo "Executing docker exec -it $container_id bash..."
        docker exec -it "$container_id" bash
    else
        echo "No ID was entered."
    fi
}

# Git Clone and Initial Setup Function
cnek() {
    if [ $# -eq 0 ]; then
        echo "Usage: clonek <repository URL>"
        return 1
    fi
    
    local repo_url="$1"
    local repo_name=$(basename "$repo_url" .git)
    
    echo "Cloning repository: $repo_url"
    git clone "$repo_url"
    
    if [ $? -eq 0 ]; then
        cd "$repo_name"
        echo "Current branch:"
        echo -e "\e[33m$(pwd)\e[0m"
        git branch
        echo "Recent commit history:"
        git log --oneline | head -n 5
    else
        echo "Clone failed"
        return 1
    fi
}

EOF

log "Aliases and functions setup completed"