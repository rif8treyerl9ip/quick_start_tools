#!/bin/bash

set -eu

python3 -m venv venv
source venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install ruff
python3 -m ruff --version
