#!/bin/bash

# Hyprland Installation Script for Ubuntu (Building from source)
# Based on official Hyprland documentation

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Hyprland Installation             ║${NC}"
echo -e "${BLUE}║     (Building from source)            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo -e "${RED}❌ Don't run this script as root!${NC}"
    exit 1
fi

# Install build dependencies
echo -e "${BLUE}📦 Installing build dependencies...${NC}"
sudo apt install -y \
    build-essential \
    cmake \
    meson \
    ninja-build \
    pkg-config \
    libwayland-dev \
    wayland-protocols \
    libcairo2-dev \
    libpango1.0-dev \
    libgl1-mesa-dev \
    libglew-dev \
    libxcb1-dev \
    libxcb-render0-dev \
    libxcb-shape0-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libpixman-1-dev \
    libudev-dev \
    libdrm-dev \
    libgbm-dev \
    libinput-dev \
    libblkid-dev \
    liblz4-dev \
    libstdc++-12-dev \
    scdoc \
    libxkbregistry0 \
    2>/dev/null || true

# Install runtime dependencies
echo -e "${BLUE}📦 Installing runtime dependencies...${NC}"
sudo apt install -y \
    waybar \
    wlogout \
    wofi \
    rofi \
    swaynotificationcenter \
    hyprlock \
    hyprpaper \
    swappy \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    brightnessctl \
    libnotify-bin \
    libgtk-3-0 \
    libgtk-layer-shell-1.0-0 \
    libnl-genl-3-dev \
    gettext \
    kitty \
    lf \
    playerctl \
    thunar \
    2>/dev/null || true

# Check if hyprland is already installed
if command -v hyprland &>/dev/null; then
    echo -e "${YELLOW}⚠️  Hyprland is already installed: $(hyprland --version 2>/dev/null)${NC}"
    read -p "Do you want to rebuild? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Clone and build Hyprland
HYPRLAND_DIR="/tmp/hyprland"
echo -e "${BLUE}📥 Cloning Hyprland...${NC}"

if [[ -d "$HYPRLAND_DIR" ]]; then
    rm -rf "$HYPRLAND_DIR"
fi

git clone --recursive https://github.com/hyprwm/Hyprland "$HYPRLAND_DIR"

cd "$HYPRLAND_DIR"

echo -e "${BLUE}🔨 Building Hyprland...${NC}"
make clean || true
meson setup build
ninja -C build
sudo ninja -C build install

# Add Hyprland to XDG_DATA_DIRS
echo 'XDG_DATA_DIRS="${XDG_DATA_DIRS}:/usr/local/share"' | sudo tee /etc/profile.d/hyprland.sh

# Update libraries
sudo ldconfig

echo -e "${GREEN}✅ Hyprland installed successfully!${NC}"
echo -e "${GREEN}Version:$(hyprland --version)${NC}"
echo ""
echo -e "${YELLOW}To login with Hyprland:${NC}"
echo "  1. Log out of your current session"
echo "  2. On the login screen, click the gear icon ⚙️"
echo "  3. Select 'Hyprland'"
echo "  4. Enter your password and log in"
echo ""
echo -e "${YELLOW}Or use from terminal:${NC}"
echo "  dbus-run-session Hyprland"
