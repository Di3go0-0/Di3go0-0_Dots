#!/usr/bin/env bash
set -e

echo "🚀 Setting up Nushell and dependencies..."

echo "==> Installing zoxide..."
sudo apt install -y zoxide

echo "==> Installing starship..."
sudo apt install -y starship

echo "==> Installing git (if missing)..."
sudo apt install -y git

echo "==> Installing carapace..."
if ! command -v carapace &>/dev/null; then
    go install mvdan.cc/sh/v3/cmd/carapace@latest
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

echo "==> Installing atuin..."
if ! command -v atuin &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://atuin.sh/install.sh | bash
fi

echo "🔧 Generating Nushell integration files..."

mkdir -p ~/.local/share/nushell

zoxide init nushell --cmd cd >~/.zoxide.nu

if command -v carapace &>/dev/null; then
    mkdir -p ~/.cache/carapace
    carapace _carapace nushell >~/.cache/carapace/init.nu
fi

if command -v atuin &>/dev/null; then
    mkdir -p ~/.local/share/atuin
    atuin init nu >~/.local/share/atuin/init.nu
fi

mkdir -p ~/.cache/starship
starship init nu >~/.cache/starship/init.nu

echo "✅ Nushell integrations ready: zoxide, carapace, atuin, starship."
echo "Remember to add to your ~/.config/nushell/config.nu:"
echo "  source ~/.zoxide.nu"
echo "  source ~/.cache/carapace/init.nu"
echo "  source ~/.local/share/atuin/init.nu"
echo "  source ~/.cache/starship/init.nu"

NU_PATH="$(which nu)"
if [ -n "$NU_PATH" ]; then
    echo "🔄 Setting Nushell as default shell..."
    chsh -s "$NU_PATH"
    echo "✅ Default shell changed to Nushell."
else
    echo "⚠️ Nushell not found, install it first with packages.sh"
fi

echo "🎉 Nushell setup complete!"
