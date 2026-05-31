#!/usr/bin/env bash
set -e

# Manual Fish setup: installs fisher + plugins matching ~/.config/fish/fish_plugins.
# NOTE: this does NOT change your default shell. Run `chsh -s $(which fish)` yourself.

echo "🐟 Installing Fish dependencies..."

if ! command -v fish &>/dev/null; then
  echo "❌ fish not installed. Run scripts/packages.sh first."
  exit 1
fi

# Optional CLI tools the fish config / plugins expect
sudo pacman -S --needed --noconfirm fzf eza bat fd

echo "📦 Installing fisher (plugin manager)..."
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

echo "📦 Installing plugins from ~/.config/fish/fish_plugins..."
fish -c 'fisher update'

# Plugins that match the functions shipped in this repo
echo "📦 Installing extra plugins (fzf.fish, nvm.fish, pj)..."
fish -c 'fisher install PatrickF1/fzf.fish'
fish -c 'fisher install jorgebucaran/nvm.fish'
fish -c 'fisher install oh-my-fish/plugin-pj'

echo ""
echo "✅ Fish setup complete."
echo ""
echo "To set Fish as your default shell (optional, do it yourself):"
echo "  echo \"\$(which fish)\" | sudo tee -a /etc/shells"
echo "  chsh -s \"\$(which fish)\""
