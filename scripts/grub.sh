#!/bin/bash

# Script to clone and install the Sekiro GRUB theme

echo "⚠️ WARNING: This script will modify your GRUB. Make sure you know what you're doing."
read -p "Do you want to continue? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Cancelled by the user."
  exit 1
fi

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/semimqmo/sekiro_grub_theme || {
  echo "Failed to clone the repository"
  exit 1
}

# Enter the repository folder
cd sekiro_grub_theme || {
  echo "Could not access the repository folder"
  exit 1
}

# Run the installation script with sudo
echo "Running the installation script..."
sudo ./install.sh || {
  echo "Failed to run install.sh"
  exit 1
}

echo "✅ Installation completed."
