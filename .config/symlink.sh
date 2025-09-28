#!/bin/bash

# Dotfiles installation script (Linux only)
# This script creates symbolic links from the dotfiles repo to the appropriate locations

set -e # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where the dotfiles are located
# Assuming the script is in src/scripts/ and dotfiles in src/.config/
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/../.config" && pwd)"

echo -e "${BLUE}🚀 Installing dotfiles for Linux...${NC}"
echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"

# Function to create backup
backup_file() {
  local file="$1"
  if [[ -e "$file" && ! -L "$file" ]]; then
    local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    mv "$file" "$backup_dir/"
    echo -e "${YELLOW}  Backed up existing file to: $backup_dir/$(basename "$file")${NC}"
  fi
}

# Function to create symbolic link
create_symlink() {
  local src="$1"
  local dest="$2"
  local desc="$3"

  echo -e "${BLUE}Installing $desc...${NC}"

  mkdir -p "$(dirname "$dest")"
  backup_file "$dest"
  rm -rf "$dest"
  ln -sf "$src" "$dest"
  echo -e "${GREEN}  ✓ $desc installed${NC}"
}

echo -e "${BLUE}📁 Creating ~/.config directory if it doesn't exist...${NC}"
mkdir -p "$HOME/.config"

# List of directories to install
declare -A CONFIGS=(
  ["fish"]="$HOME/.config/fish"
  ["009 󰉋  git"]="$HOME/.config/git"
  ["005 󰉋  hypr"]="$HOME/.config/hypr"
  ["003 󰉋  kitty"]="$HOME/.config/kitty"
  ["010 󰉋  lazygit"]="$HOME/.config/lazygit"
  ["012 󰉋  nushell"]="$HOME/.config/nushell"
  ["006 󰉋  nvim"]="$HOME/.config/nvim"
  ["008 󰉋  rofi"]="$HOME/.config/rofi"
  ["004 󰉋  waybar"]="$HOME/.config/waybar"
  ["002 󰉋  zellij"]="$HOME/.config/zellij"
)

# Loop through and install only specified configs
for dir in "${!CONFIGS[@]}"; do
  src="$DOTFILES_DIR/$dir"
  dest="${CONFIGS[$dir]}"
  if [[ -d "$src" ]]; then
    create_symlink "$src" "$dest" "$dir config"
  fi
done

echo -e "\n${GREEN}🎉 Dotfiles installation completed!${NC}"
echo -e "\n${BLUE}📋 Next steps:${NC}"
echo -e "  1. Restart your terminal or run: ${YELLOW}source ~/.config/fish/config.fish${NC}"
echo -e "  2. Configure any application-specific settings as needed"

if [[ -d "$HOME/.dotfiles_backup" ]]; then
  echo -e "\n${YELLOW}📦 Backed up files are stored in: ~/.dotfiles_backup${NC}"
fi

echo -e "\n${GREEN}✨ Happy coding!${NC}"
