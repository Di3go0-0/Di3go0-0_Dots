#!/bin/bash

# Simple dotfiles installer - calls setup.sh
# Use setup.sh directly for the full interactive experience

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$SCRIPT_DIR/setup.sh" ]]; then
    exec bash "$SCRIPT_DIR/setup.sh"
else
    echo "Error: setup.sh not found in $SCRIPT_DIR"
    exit 1
fi
