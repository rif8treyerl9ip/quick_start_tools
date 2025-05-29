# .devcontainer/Dockerfile

# FROM ubuntu:24.04
FROM nvidia/cuda:12.9.0-devel-ubuntu24.04

RUN apt-get update && \
    apt-get install -y \
    curl \
    # ping
    iputils-ping \
    gnupg \
    jq \
    sudo \
    # ssh, scp
    openssh-client \
    python3 \
    python3-pip \
    python3-venv \
    tmux \
    zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ユーザーを作成（VSCodeが使用）
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd vscode \
    && useradd -g vscode -m -s /bin/zsh vscode \
    && echo "vscode ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

USER vscode

WORKDIR /workspace
