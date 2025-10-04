#!/bin/bash

# Initialize all scripts in the scripts directory

# Execute packages script
if [ -f "$(dirname "$0")/scripts/packages.sh" ]; then
  bash "$(dirname "$0")/scripts/packages.sh"
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
