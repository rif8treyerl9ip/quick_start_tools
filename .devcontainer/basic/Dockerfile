# .devcontainer/Dockerfile

# TODO: Make base image selectable via docker compose
FROM ubuntu:24.04
# FROM python:3.12-slim
# FROM debian:bookworm-slim
# FROM nvidia/cuda:12.9.0-devel-ubuntu24.04

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    # sleep
    coreutils \
    curl \
    # ping
    iputils-ping \
    gnupg \
    # for github cli
    less \
    jq \
    nano \
    # ssh, scp
    openssh-client \
    python3 \
    python3-pip \
    python3-venv \
    # for ssh-agent
    socat \
    sudo \
    tmux \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
