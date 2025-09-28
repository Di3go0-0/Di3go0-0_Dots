#!/usr/bin/env bash
set -e

echo "🚀 Installing dependencies for Nushell..."

# Install dependencies from official repos
sudo pacman -S --needed zoxide atuin starship git base-devel --noconfirm

# Install carapace from AUR (requires yay; if not available, use makepkg)
if ! command -v carapace &>/dev/null; then
  if command -v yay &>/dev/null; then
    yay -S --needed carapace-bin --noconfirm
  else
    echo "Installing carapace-bin manually from AUR..."
    cd /tmp || exit 1
    rm -rf carapace-bin
    git clone https://aur.archlinux.org/carapace-bin.git
    cd carapace-bin || exit 1
    makepkg -si --noconfirm
  fi
fi

echo "🔧 Generating Nushell integration files..."

# zoxide
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

# carapace
mkdir -p ~/.cache/carapace
carapace _carapace nushell | save -f ~/.cache/carapace/init.nu

# atuin
mkdir -p ~/.local/share/atuin
atuin init nu | save -f ~/.local/share/atuin/init.nu

# starship
mkdir -p ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

echo "✅ Nushell integrations ready: zoxide, carapace, atuin, starship."
echo "Remember to edit your ~/.config/nushell/config.nu and make sure it contains:"
echo '  source ~/.zoxide.nu'
echo '  source ~/.cache/carapace/init.nu'
echo '  source ~/.local/share/atuin/init.nu'
echo '  source ~/.cache/starship/init.nu'

# Set Nushell as the default shell
NU_PATH="$(which nu)"
if [ -n "$NU_PATH" ]; then
  echo "🔄 Setting Nushell as your default shell ($NU_PATH)..."
  chsh -s "$NU_PATH"
  echo "✅ Default shell changed to Nushell."
else
  echo -e "${RED}❌ Nushell not found, cannot change shell.${NC}"
fi

echo "🎉 Installation and configuration complete!"
