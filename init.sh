#!/bin/bash

# Initialize dotfiles on Ubuntu with Hyprland
# This script installs Hyprland and sets up all dependencies

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Ubuntu Dotfiles Setup              ║${NC}"
echo -e "${BLUE}║     with Hyprland                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"

# Ask for Hyprland installation
echo -e "\n${YELLOW}Do you want to install Hyprland from source? (y/N)${NC}"
read -p "This is recommended for Ubuntu: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Install Hyprland
    if [ -f "$(dirname "$0")/scripts/install-hyprland.sh" ]; then
        echo -e "\n${BLUE}🔧 Installing Hyprland...${NC}"
        bash "$(dirname "$0")/scripts/install-hyprland.sh"
    fi
fi

# Execute packages script (verify dependencies)
if [ -f "$(dirname "$0")/scripts/packages.sh" ]; then
  echo -e "\n${BLUE}📦 Verifying dependencies...${NC}"
  bash "$(dirname "$0")/scripts/packages.sh"
fi

# Backup critical files before overwriting
if [ -f "$(dirname "$0")/scripts/backup-critical.sh" ]; then
  echo -e "\n${BLUE}🔐 Backing up critical files...${NC}"
  bash "$(dirname "$0")/scripts/backup-critical.sh" backup
fi

# Execute symlink script
if [ -f "$(dirname "$0")/scripts/symlink.sh" ]; then
  echo -e "\n${BLUE}🔗 Creating symbolic links...${NC}"
  bash "$(dirname "$0")/scripts/symlink.sh"
fi

# Execute nushell script
if [ -f "$(dirname "$0")/scripts/nushell.sh" ]; then
  echo -e "\n${BLUE}🐚 Setting up Nushell...${NC}"
  bash "$(dirname "$0")/scripts/nushell.sh"
fi

# Execute spotify + spicetify
if [ -f "$(dirname "$0")/scripts/spotify.sh" ]; then
  echo -e "\n${BLUE}🎵 Setting up Spotify + Spicetify...${NC}"
  bash "$(dirname "$0")/scripts/spotify.sh"
fi

# Execute post-setup tasks
if [ -f "$(dirname "$0")/scripts/post-setup.sh" ]; then
  echo -e "\n${BLUE}⚙️  Running post-setup...${NC}"
  bash "$(dirname "$0")/scripts/post-setup.sh"
fi

# Verify installation
if [ -f "$(dirname "$0")/scripts/verify.sh" ]; then
  echo -e "\n${BLUE}🔍 Verifying installation...${NC}"
  bash "$(dirname "$0")/scripts/verify.sh"
fi

echo -e "\n${GREEN}✅ Dotfiles setup completed!${NC}"
echo -e "${YELLOW}To start Hyprland, log out and select it from the login screen.${NC}"
