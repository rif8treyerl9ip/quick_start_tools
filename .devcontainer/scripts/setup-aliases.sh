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

# 追加のエイリアス（必要に応じて拡張可能）
# alias ll='ls -la'
# alias la='ls -A'
# alias l='ls -CF'

EOF

log "Aliases and functions setup completed"