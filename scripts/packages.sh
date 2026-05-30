#!/bin/bash

# Arch Linux installer for Di3go0-0's dotfiles.
# Instala yay + paquetes oficiales + AUR alineados con la config actual.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting installation script...${NC}"

install_yay() {
  echo -e "${GREEN}Installing yay (AUR helper)...${NC}"
  if ! command -v yay &>/dev/null; then
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
    echo -e "${GREEN}yay installed.${NC}"
  else
    echo -e "${YELLOW}yay already installed.${NC}"
  fi
}

install_packages() {
  echo -e "${GREEN}Updating system...${NC}"
  sudo pacman -Syu --noconfirm

  echo -e "${GREEN}Installing packages from official repos...${NC}"
  sudo pacman -S --needed --noconfirm \
    `# --- Hyprland core ---` \
    hyprland \
    hyprlock \
    hypridle \
    awww \
    `# --- shells & terminal ---` \
    kitty \
    fish \
    zellij \
    starship \
    `# --- editor & dev ---` \
    neovim \
    nodejs \
    npm \
    `# --- UI bar / launcher / notifs ---` \
    waybar \
    rofi \
    swaync \
    wlogout \
    `# --- screenshot & clipboard ---` \
    grim \
    slurp \
    swappy \
    wl-clipboard \
    `# --- audio ---` \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    pipewire-jack \
    wireplumber \
    pamixer \
    playerctl \
    `# --- network & bluetooth ---` \
    networkmanager \
    network-manager-applet \
    blueman \
    `# --- file managers ---` \
    nautilus \
    dolphin \
    ranger \
    `# --- system / auth ---` \
    polkit-kde-agent \
    brightnessctl \
    xdg-user-dirs \
    `# --- libs / tooling ---` \
    jq \
    libnotify \
    gettext \
    bat \
    imagemagick \
    `# --- fonts ---` \
    ttf-cascadia-code-nerd \
    `# --- apps ---` \
    dbeaver

  echo -e "${GREEN}Installing packages from AUR via yay...${NC}"
  yay -S --needed --noconfirm \
    `# --- Hyprland extras ---` \
    hyprpicker \
    hyprshade \
    grimblast-git \
    `# --- shells / dev ---` \
    nushell \
    nvm \
    lazygit \
    github-cli \
    `# --- theming ---` \
    wallust \
    nwg-look \
    `# --- clipboard & misc ---` \
    cliphist \
    bitwarden \
    `# --- browser ---` \
    google-chrome
}

# Main
install_yay
install_packages

echo -e "${GREEN}All packages installed successfully!${NC}"
echo -e "${YELLOW}Note: hyprpaper, hyprsunset, wofi y eww fueron removidos del script${NC}"
echo -e "${YELLOW}(reemplazados por awww + hyprshade + rofi).${NC}"
