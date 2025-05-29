#!/bin/bash

# zshをデフォルトシェルに設定
sudo chsh -s $(which zsh) vscode

# Preztoのインストールとプロンプトの設定
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Preztoのプロンプト設定
echo "autoload -Uz promptinit" >> ~/.zshrc
echo "promptinit" >> ~/.zshrc

# echo "prompt elite2 yellow" >> ~/.zshrc
echo "PROMPT='%F{yellow}%n@%m%F{white}:%f %B%~%b %# '" >> ~/.zshrc
# zsh-autosuggestionsのセットアップ
mkdir -p ~/.zsh_custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh_custom/plugins/zsh-autosuggestions
echo 'export ZSH_CUSTOM=~/.zsh_custom' >> ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

# zshの自動修正機能を無効化
echo "unsetopt CORRECT" >> ~/.zshrc  # e.g. jq → _jq
echo "unsetopt CORRECT_ALL" >> ~/.zshrc  # e.g. ls fiel.txt → ls file.txt
