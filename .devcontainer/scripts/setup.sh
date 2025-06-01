# #!/bin/bash

# # =======================================================
# # DevContainer Setup Script
# # =======================================================
# # Execution order: zsh setup → alias setup → SSH verification

# set -e

# SCRIPT_DIR="/workspace/scripts"
# LOG_FILE="/tmp/devcontainer-setup.log"
# # echo "SCRIPT_DIR: $SCRIPT_DIR"
# # echo "LOG_FILE: $LOG_FILE"
# ls -l ./ && sleep 479382

# # ログ関数
# log() {
#     echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
# }

# log "=== DevContainer Setup Started ==="

# # 1. Zsh設定のセットアップ
# log "Setting up Zsh configuration..."
# if [ -f "$SCRIPT_DIR/setup-zsh.sh" ]; then
#     zsh "$SCRIPT_DIR/setup-zsh.sh"
#     log "Zsh setup completed"
# else
#     log "Warning: setup-zsh.sh not found"
# fi

# log "Setting up aliases..."
# if [ -f "$SCRIPT_DIR/setup-aliases.sh" ]; then
#     zsh "$SCRIPT_DIR/setup-aliases.sh"
#     log "Aliases setup completed"
# else
#     log "Warning: setup-aliases.sh not found"
# fi

# log "Checking SSH configuration..."
# if [ -f "$SCRIPT_DIR/check-ssh.sh" ]; then
#     zsh "$SCRIPT_DIR/check-ssh.sh"
#     log "SSH check completed"
# else
#     log "Warning: check-ssh.sh not found"
# fi

# log "=== DevContainer Setup Completed ==="
# log "Log file: $LOG_FILE"