#!/bin/bash

set -eu

WORK_DIR=~/path/to/work_dir
CONFIG="$WORK_DIR/ruff_sample.toml"

exclude_dirs=(
    "~/test"
)

if [ ! -d "$WORK_DIR/.venv" ]; then
   echo "Creating virtual environment at $WORK_DIR/.venv"
   python3 -m venv "$WORK_DIR/.venv"
   source "$WORK_DIR/.venv/bin/activate"
   python3 -m pip install --upgrade pip
   pip3 install ruff shellcheck-py
   echo "Installed ruff version: $(ruff --version)"
else
   echo "Using existing ruff installation"
fi

source "$WORK_DIR/.venv/bin/activate"

if [ $# -eq 1 ]; then
    dir="$1"
else
    echo "Usage: $0 <path>"
    exit 1
fi

# ruff
echo "Running ruff..."
ruff format --config "$config" "$dir"
ruff check --config "$config" --fix "$dir"

# shellcheck
echo -e "\nRunning shellcheck..."
find "$dir" -type f -name "*.sh" \
    $(printf "! -path \"*/%s/*\" " "${exclude_dirs[@]}") \
    -exec shellcheck -S warning -f tty '{}' \;
