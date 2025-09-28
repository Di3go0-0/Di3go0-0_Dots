$()$(
  bash
  #!/usr/bin/env bash

  # Instalar dependencias desde repos oficiales
  sudo pacman -S --needed zoxide atuin starship git base-devel --noconfirm

  # Instalar carapace desde AUR (requiere yay, si no tienes usa makepkg)
  if ! command -v carapace &>/dev/null; then
    if command -v yay &>/dev/null; then
      yay -S --needed carapace-bin --noconfirm
    else
      echo "Instalando carapace-bin manualmente desde AUR..."
      cd /tmp || exit 1
      rm -rf carapace-bin
      git clone https://aur.archlinux.org/carapace-bin.git
      cd carapace-bin || exit 1
      makepkg -si --noconfirm
    fi
  fi

  # Generar archivos de integración

  # zoxide
  zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

  # carapace
  mkdir ~/.cache
  carapace _carapace nushell | save -f ~/.cache/carapace/init.nu

  # atuin
  mkdir ~/.local
  mkdir ~/.local/share
  mkdir ~/.local/share/atuin
  atuin init nu | save -f ~/.local/share/atuin/init.nu

  # starship
  mkdir ~/.cache/starship
  starship init nu | save -f ~/.cache/starship/init.nu

  echo "✅ Integraciones de Nushell listas: zoxide, carapace, atuin, starship."
  echo "Recuerda editar tu ~/.config/nushell/config.nu y asegurarte de tener:"
  echo '  source ~/.zoxide.nu'
  echo '  source ~/.cache/carapace/init.nu'
  echo '  source ~/.local/share/atuin/init.nu'
  echo '  source ~/.cache/starship/init.nu'
)$()
