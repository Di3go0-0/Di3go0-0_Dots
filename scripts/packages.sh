# Arch Linux Installer Script
# This script installs yay and several packages from official repos and AUR

set -e # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting installation script...${NC}"

# Function to install yay
install_yay() {
  echo -e "${GREEN}Installing yay (AUR helper)...${NC}"
  if ! command -v yay &>/dev/null; then
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
    echo -e "${GREEN}yay installed successfully.${NC}"
  else
    echo -e "${YELLOW}yay is already installed.${NC}"
  fi
}

# Function to install packages via pacman or yay
install_packages() {
  echo -e "${GREEN}Updating system...${NC}"
  sudo pacman -Syu --noconfirm

  echo -e "${GREEN}Installing packages from official repos...${NC}"
  sudo pacman -S --needed --noconfirm \
    neovim \
    zellij \
    rofi \
    waybar \
    wofi \
    swaync \
    brightnessctl \
    nodejs \
    npm \
    wl-clipboard

  echo -e "${GREEN}Installing packages from AUR via yay...${NC}"
  yay -S --needed --noconfirm \
    lazygit \
    github-cli \
    nushell \
    nvm \
    startship

}

# Main script execution
install_yay
install_packages

echo -e "${GREEN}All packages installed successfully!${NC}"
