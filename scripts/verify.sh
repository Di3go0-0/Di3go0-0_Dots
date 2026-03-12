#!/bin/bash

# Dotfiles Verification Script
# Checks if the installation was successful and identifies any issues

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Counter for issues
ISSUES=0
WARNINGS=0

echo -e "${BLUE}🔍 Verifying dotfiles installation...${NC}"
echo -e "${BLUE}=====================================${NC}\n"

# Function to report success
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to report warning
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    ((WARNINGS++))
}

# Function to report error
error() {
    echo -e "${RED}❌ $1${NC}"
    ((ISSUES++))
}

# Function to report info
info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

# Check if essential symlinks exist
echo -e "${BLUE}📋 Checking essential symlinks...${NC}"
essential_configs=("hypr" "waybar" "swaync" "rofi" "nvim" "starship.toml")

for config in "${essential_configs[@]}"; do
    if [[ -L "$HOME/.config/$config" ]]; then
        success "✓ $config symlink exists"
    else
        error "$config symlink missing"
    fi
done

# Check if scripts are executable
echo -e "\n${BLUE}🔧 Checking scripts permissions...${NC}"
if [[ -f "$HOME/.config/hypr/scripts" ]]; then
    scripts_count=$(find "$HOME/.config/hypr/scripts" -name "*.sh" -executable | wc -l)
    total_scripts=$(find "$HOME/.config/hypr/scripts" -name "*.sh" | wc -l)
    if [[ $scripts_count -eq $total_scripts ]]; then
        success "All $total_scripts hypr scripts are executable"
    else
        error "Only $scripts_count/$total_scripts hypr scripts are executable"
    fi
fi

# Check if icon cache is valid
echo -e "\n${BLUE}🎨 Checking icon cache...${NC}"
if [[ -f "$HOME/.local/share/icons/icon-theme.cache" ]]; then
    success "Icon cache exists"
else
    warning "Icon cache might be missing - run post-setup.sh"
fi

# Check if essential applications are available
echo -e "\n${BLUE}📦 Checking essential applications...${NC}"
essential_apps=("hyprland" "waybar" "swaync" "rofi" "nvim" "starship" "lf")

for app in "${essential_apps[@]}"; do
    if command -v "$app" >/dev/null 2>&1; then
        success "✓ $app is available"
    else
        error "$app is not installed or not in PATH"
    fi
done

# Check wallpaper organization
echo -e "\n${BLUE}🖼️  Checking wallpaper organization...${NC}"
wallpaper_dirs=("anime" "nature" "city" "gaming" "general")
base_dir="$HOME/Pictures/wallpapers"

if [[ -d "$base_dir" ]]; then
    for dir in "${wallpaper_dirs[@]}"; do
        if [[ -d "$base_dir/$dir" ]]; then
            success "✓ $base_dir/$dir exists"
        else
            warning "$base_dir/$dir missing"
        fi
    done
else
    warning "Wallpaper directory not found"
fi

# Check shell configuration (Nushell)
echo -e "\n${BLUE}🐚 Checking shell configuration...${NC}"
if [[ -f "$HOME/.config/nushell/config.nu" ]]; then
    success "Nushell config linked"
    if command -v nu >/dev/null 2>&1; then
        success "Nushell is available"
    else
        warning "Nushell not installed"
    fi
else
    warning "Nushell config not found"
fi

# Check theme consistency
echo -e "\n${BLUE}🎭 Checking theme consistency...${NC}"
if [[ -f "$HOME/.config/gtk-3.0/settings.ini" ]]; then
    theme=$(grep "gtk-theme-name" "$HOME/.config/gtk-3.0/settings.ini" 2>/dev/null | cut -d'=' -f2 | tr -d ' ' || echo "unknown")
    if [[ -n "$theme" && "$theme" != "unknown" ]]; then
        success "GTK theme configured: $theme"
    else
        warning "GTK theme not properly configured"
    fi
else
    warning "GTK configuration not found"
fi

# Summary
echo -e "\n${BLUE}=====================================${NC}"
echo -e "${BLUE}📊 VERIFICATION SUMMARY${NC}"
echo -e "${BLUE}=====================================${NC}"

if [[ $ISSUES -eq 0 ]]; then
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
else
    echo -e "${RED}❌ Found $ISSUES issue(s) that need attention${NC}"
fi

if [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}⚠️  $WARNINGS warning(s) - installation should work but may not be optimal${NC}"
fi

echo -e "\n${BLUE}📋 Quick fixes:${NC}"
if [[ $ISSUES -gt 0 ]]; then
    echo -e "${YELLOW}  • Run: ./scripts/symlink.sh${NC}"
    echo -e "${YELLOW}  • Run: ./scripts/post-setup.sh${NC}"
fi

if [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}  • Check the warnings above for manual fixes${NC}"
fi

echo -e "\n${GREEN}✨ Verification completed!${NC}"

# Exit with appropriate code
if [[ $ISSUES -gt 0 ]]; then
    exit 1
else
    exit 0
fi