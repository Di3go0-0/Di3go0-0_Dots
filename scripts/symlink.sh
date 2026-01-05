#!/bin/bash

# Unified Dotfiles Symlink Script
# Creates symbolic links from repo dotfiles to ~/.config
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get the dotfiles repo directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$REPO_DIR/.config"

echo -e "${BLUE}🚀 Creating symbolic links for dotfiles...${NC}"
echo -e "${BLUE}Repo directory: $REPO_DIR${NC}"
echo -e "${BLUE}Config directory: $CONFIG_DIR${NC}"

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

    echo -e "${BLUE}Linking $desc...${NC}"

    mkdir -p "$(dirname "$dest")"
    backup_file "$dest"
    rm -rf "$dest"
    ln -sf "$src" "$dest"
    echo -e "${GREEN}  ✓ $desc linked${NC}"
}

# Ensure ~/.config exists
echo -e "${BLUE}📁 Creating ~/.config directory if needed...${NC}"
mkdir -p "$HOME/.config"

# Process all directories and files in .config
if [[ -d "$CONFIG_DIR" ]]; then
    echo -e "${BLUE}📋 Processing all config files...${NC}"
    
    for item in "$CONFIG_DIR"/*; do
        if [[ -e "$item" ]]; then
            item_name=$(basename "$item")
            dest_path="$HOME/.config/$item_name"
            create_symlink "$item" "$dest_path" "$item_name"
        fi
    done
else
    echo -e "${RED}❌ Config directory not found: $CONFIG_DIR${NC}"
    exit 1
fi

# Additional resources (wallpapers, fonts, etc.)
RESOURCES_DIR="$REPO_DIR/Resources"
if [[ -d "$RESOURCES_DIR" ]]; then
    echo -e "${BLUE}🎨 Linking additional resources...${NC}"
    
    # Link wallpapers to Pictures
    if [[ -d "$RESOURCES_DIR/wallpapers" ]]; then
        mkdir -p "$HOME/Pictures"
        create_symlink "$RESOURCES_DIR/wallpapers" "$HOME/Pictures/wallpapers" "wallpapers"
    fi
    
    # Link to resources in home directory
    create_symlink "$RESOURCES_DIR" "$HOME/.config/Resources" "Resources"
fi

echo -e "\n${GREEN}🎉 Dotfiles linking completed!${NC}"
echo -e "\n${BLUE}📋 Next steps:${NC}"
echo -e "  1. Restart your terminal or source your shell config"
echo -e "  2. Install missing dependencies with: ${YELLOW}./scripts/packages.sh${NC}"
echo -e "  3. Configure any application-specific settings as needed"

if [[ -d "$HOME/.dotfiles_backup" ]]; then
    echo -e "\n${YELLOW}📦 Backed up files are stored in: ~/.dotfiles_backup${NC}"
fi

echo -e "\n${GREEN}✨ Enjoy your new dotfiles!${NC}"