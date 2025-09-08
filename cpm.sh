#!/bin/bash

# ─────────────────────────────────────────────
# 📦 CPM(custom package manager for python) – Add and manage Python dependencies
# - Automatically installs and pins packages
# - Supports `-r` / `--refresh` to clean & rebuild
# - Auto-installs pip-tools if missing
# - Installs all packages from requirements.txt with `-i`
# - Automatically sets up and activates a virtual environment
# ─────────────────────────────────────────────

VENV_DIR="venv"

# Create venv if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
  echo "😈 Virtual environment not found. Creating $VENV_DIR..."
  python3 -m venv "$VENV_DIR"
fi

# Activate venv if not already active
if [ -z "$VIRTUAL_ENV" ]; then
  echo "🔗 Activating virtual environment..."
  # shellcheck disable=SC1090
  source "$VENV_DIR/bin/activate"
fi

# Ensure pip-tools is installed
if ! command -v pip-compile &> /dev/null; then
  echo "🛠 pip-tools not found. Installing..."
  pip install pip-tools
fi

# Refresh mode
if [[ "$1" == "-r" || "$1" == "--refresh" ]]; then
  echo "🔄 Refreshing requirements.in from current environment..."

  pip list --not-required --format=freeze | cut -d= -f1 | while read -r pkg; do
    pip freeze | grep -i "^$pkg==" || true
  done | sort -f > requirements.in

  echo "✅ requirements.in updated"
  pip-compile requirements.in
  echo "✅ requirements.txt compiled"
  exit 0
fi

# Install from requirements.txt
if [[ "$1" == "-i" || "$1" == "--install" ]]; then
  echo "🔧 Installing packages from requirements.txt..."
  pip install -r requirements.txt
  exit 0
fi

# Normal add mode
if [ "$#" -lt 1 ]; then
  echo "Usage: ./cmp.sh <package1> [package2] ..."
  echo "       ./cmp.sh --refresh        # clean & rebuild requirements.in/.txt"
  echo "       ./cmp.sh --install        # install from requirements.txt"
  exit 1
fi

for PACKAGE in "$@"; do
  pip install "$PACKAGE"

  PACKAGE_NAME=$(echo "$PACKAGE" | cut -d'=' -f1 | cut -d'[' -f1)
  EXACT=$(pip freeze | grep -i "^$PACKAGE_NAME==")

  if [ -z "$EXACT" ]; then
    echo "⚠️  Could not find installed package: $PACKAGE"
    continue
  fi

  if grep -i "^$PACKAGE_NAME==" requirements.in > /dev/null; then
    echo "✔️  $PACKAGE_NAME already in requirements.in"
  else
    echo -e "\n$EXACT" >> requirements.in
    echo "➕ Added $EXACT to requirements.in"
  fi
done

pip-compile requirements.in
