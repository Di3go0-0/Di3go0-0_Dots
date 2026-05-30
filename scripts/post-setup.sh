#!/bin/bash

# Post-Setup Script
# Runs after all dotfiles are linked to finalize the setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Running post-setup tasks...${NC}"

# Update GTK icon cache
echo -e "${BLUE}🔄 Updating GTK icon cache...${NC}"
if [[ -d "$HOME/.local/share/icons" ]]; then
    gtk-update-icon-cache -f -t "$HOME/.local/share/icons/" 2>/dev/null && echo -e "${GREEN}  ✓ Icon cache updated${NC}" || echo -e "${YELLOW}  ⚠ Icon cache update failed (may not be critical)${NC}"
else
    echo -e "${YELLOW}  ℹ No local icons directory found, skipping cache update${NC}"
fi

# Rebuild font cache (if fonts were added)
echo -e "${BLUE}🔄 Rebuilding font cache...${NC}"
if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -fv 2>/dev/null && echo -e "${GREEN}  ✓ Font cache updated${NC}" || echo -e "${YELLOW}  ⚠ Font cache update failed${NC}"
else
    echo -e "${YELLOW}  ℹ fc-cache not found, skipping font cache update${NC}"
fi

# Bootstrap wallust theme (genera palette.rasi, colors-wallust.css/.conf/.lua que
# glass.rasi / style.css / kitty.conf / theme.lua referencian via @import / include).
# Sin este paso, en fresh install fallan por archivos faltantes.
echo -e "${BLUE}🎨 Bootstrapping wallust theme (DD01)...${NC}"
if command -v wallust >/dev/null 2>&1; then
    if wallust cs DD01 >/dev/null 2>&1; then
        echo -e "${GREEN}  ✓ Theme DD01 aplicado (rofi/waybar/kitty/hypr colors generados)${NC}"
        mkdir -p "$HOME/.cache"
        echo "DD01" > "$HOME/.cache/current-theme"
    else
        echo -e "${YELLOW}  ⚠ wallust cs DD01 falló (¿faltan colorschemes en ~/.config/wallust/?)${NC}"
    fi
else
    echo -e "${YELLOW}  ℹ wallust no instalado, skipping theme bootstrap${NC}"
fi

echo -e "\n${GREEN}✅ Post-setup completed!${NC}"
echo -e "${YELLOW}💡 Note: You may need to restart your session for all changes to take effect.${NC}"