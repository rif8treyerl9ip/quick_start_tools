#!/bin/bash

# =======================================================
# Zsh Configuration Setup
# =======================================================
# Zshの設定とPreztoのインストールを行います（元のコマンドを保持）

set -e

log() {
    echo "[ZSH] $1"
}

log "Starting Zsh configuration setup..."

# zshをデフォルトシェルに設定
log "Setting zsh as default shell..."
sudo chsh -s $(which zsh) vscode

# Preztoのインストールとプロンプトの設定
log "Installing Prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# 元のコマンドをそのまま実行（zshコンテキストで実行）
log "Setting up Prezto configuration files..."
zsh -c '
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
'

# Preztoのプロンプト設定
log "Configuring Prezto prompt..."
echo "autoload -Uz promptinit" >> ~/.zshrc
echo "promptinit" >> ~/.zshrc

# echo "prompt elite2 yellow" >> ~/.zshrc
echo "PROMPT='%F{yellow}%n@%m%F{white}:%f %B%~%b %# '" >> ~/.zshrc

# zsh-autosuggestionsのセットアップ
log "Setting up zsh-autosuggestions..."
mkdir -p ~/.zsh_custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh_custom/plugins/zsh-autosuggestions
echo 'export ZSH_CUSTOM=~/.zsh_custom' >> ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

# zshの自動修正機能を無効化
log "Disabling zsh auto-correction..."
echo "unsetopt CORRECT" >> ~/.zshrc  # e.g. jq → _jq
echo "unsetopt CORRECT_ALL" >> ~/.zshrc  # e.g. ls fiel.txt → ls file.txt

log "Zsh configuration completed successfully"