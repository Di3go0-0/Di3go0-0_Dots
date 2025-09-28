#!/bin/bash

# Initialize all scripts in the scripts directory

# Execute packages script
if [ -f "$(dirname "$0")/packages.sh" ]; then
  bash "$(dirname "$0")/packages.sh"
fi

# Execute symlink script
if [ -f "$(dirname "$0")/symlink.sh" ]; then
  bash "$(dirname "$0")/symlink.sh"
fi

# Execute nushell script
if [ -f "$(dirname "$0")/nushell.sh" ]; then
  bash "$(dirname "$0")/nushell.sh"
fi

