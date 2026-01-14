#!/bin/bash

# Initialize all scripts in the scripts directory

# Execute packages script
if [ -f "$(dirname "$0")/scripts/packages.sh" ]; then
  bash "$(dirname "$0")/scripts/packages.sh"
fi

# Backup critical files before overwriting
if [ -f "$(dirname "$0")/scripts/backup-critical.sh" ]; then
  echo -e "\n${BLUE}🔐 Backing up critical files...${NC}"
  bash "$(dirname "$0")/scripts/backup-critical.sh" backup
fi

# Execute symlink script
if [ -f "$(dirname "$0")/scripts/symlink.sh" ]; then
  bash "$(dirname "$0")/scripts/symlink.sh"
fi

# Execute nushell script
if [ -f "$(dirname "$0")/scripts/nushell.sh" ]; then
  bash "$(dirname "$0")/scripts/nushell.sh"
fi

# # Execute imagen
# if [ -f "$(dirname "$0")/scripts/imagen.sh" ]; then
#   bash "$(dirname "$0")/scripts/imagen.sh"
# fi

# Execute grub
if [ -f "$(dirname "$0")/scripts/grub.sh" ]; then
  bash "$(dirname "$0")/scripts/grub.sh"
fi

# Execute spotify
if [ -f "$(dirname "$0")/scripts/spotify.sh" ]; then
  bash "$(dirname "$0")/scripts/spotify.sh"
fi

# SDDM theme
if [ -f "$(dirname "$0")/scripts/sddm-astronaut-setup.sh" ]; then
  bash "$(dirname "$0")/scripts/sddm-astronaut-setup.sh"
fi

# Execute post-setup tasks
if [ -f "$(dirname "$0")/scripts/post-setup.sh" ]; then
  bash "$(dirname "$0")/scripts/post-setup.sh"
fi

# Verify installation
if [ -f "$(dirname "$0")/scripts/verify.sh" ]; then
  echo -e "\n${BLUE}🔍 Verifying installation...${NC}"
  bash "$(dirname "$0")/scripts/verify.sh"
fi
