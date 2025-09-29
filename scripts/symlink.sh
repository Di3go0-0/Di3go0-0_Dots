#!/usr/bin/env bash
set -e

# Ir a la carpeta padre de scripts (src/)
cd "$(dirname "$0")/.."

# Ejecutar stow sobre la carpeta .config
stow -t ~/.config .config --adopt
