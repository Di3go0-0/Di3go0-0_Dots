$()$(
  bash
  #!/usr/bin/env bash

  # Instalar dependencias desde repos oficiales (Ubuntu)
  sudo apt install -y zoxide atuin starship git

  # Instalar carapace con go
  if ! command -v carapace &>/dev/null; then
    go install mvdan.cc/sh/v3/cmd/carapace@latest
    export PATH="$PATH:$(go env GOPATH)/bin"
  fi

  # Generar archivos de integración

  # zoxide
  zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

  # carapace
  mkdir -p ~/.cache
  carapace _carapace nushell | save -f ~/.cache/carapace/init.nu

  # atuin
  mkdir -p ~/.local/share/atuin
  atuin init nu | save -f ~/.local/share/atuin/init.nu

  # starship
  mkdir -p ~/.cache/starship
  starship init nu | save -f ~/.cache/starship/init.nu

  echo "✅ Integraciones de Nushell listas: zoxide, carapace, atuin, starship."
  echo "Recuerda editar tu ~/.config/nushell/config.nu y asegurarte de tener:"
  echo "  source ~/.zoxide.nu"
  echo "  source ~/.cache/carapace/init.nu"
  echo "  source ~/.local/share/atuin/init.nu"
  echo "  source ~/.cache/starship/init.nu"
)$()
