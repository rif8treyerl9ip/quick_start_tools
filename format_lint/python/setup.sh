#!/bin/bash

set -eu

python3 -m venv format_lint/python/venv
source format_lint/python/venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install pre-commit
# python3 -m pip install ruff
# python3 -m ruff --version
