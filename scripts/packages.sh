#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting Ubuntu dotfiles setup...${NC}"

check_install() {
    if command -v "$1" &>/dev/null; then
        echo -e "${YELLOW}  $1 is already installed${NC}"
        return 0
    fi
    return 1
}

install_if_missing() {
    local pkg="$1"
    local cmd="${2:-$1}"
    
    if check_install "$cmd"; then
        return 1
    fi
    
    echo -e "${GREEN}  Installing $pkg...${NC}"
    sudo apt install -y "$pkg" 2>/dev/null || echo -e "${RED}  Failed to install $pkg${NC}"
    return 0
}

echo -e "${GREEN}Checking and installing dependencies...${NC}"

echo -e "${BLUE}→ Core packages${NC}"
install_if_missing "waybar"
install_if_missing "wlogout"
install_if_missing "wofi"
install_if_missing "rofi"
install_if_missing "swaynotificationcenter" "swaync"
install_if_missing "hyprlock"
install_if_missing "hyprpaper"
install_if_missing "swappy"
install_if_missing "grim"
install_if_missing "wl-clipboard"
install_if_missing "cliphist"
install_if_missing "brightnessctl"
install_if_missing "libnotify-bin" "notify-send"

echo -e "${BLUE}→ Shell and tools${NC}"
install_if_missing "nushell" "nu"
install_if_missing "starship"
install_if_missing "lazygit"
install_if_missing "ranger"
install_if_missing "bat"
install_if_missing "jq"
install_if_missing "imagemagick"
install_if_missing "gettext"
install_if_missing "xdg-user-dirs"

echo -e "${BLUE}→ Development tools${NC}"
install_if_missing "neovim"
install_if_missing "nodejs"
install_if_missing "npm"
install_if_missing "git"
install_if_missing "gh"
install_if_missing "golang-go" "go"
install_if_missing "curl"

echo -e "${BLUE}→ Bluetooth${NC}"
install_if_missing "blueman"

echo -e "${BLUE}→ Fonts${NC}"
install_if_missing "fonts-font-awesome"
install_if_missing "fonts-jetbrains-mono"

echo -e "${GREEN}Dependencies check completed!${NC}"
