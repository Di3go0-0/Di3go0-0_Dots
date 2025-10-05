#!/usr/bin/env bash

# Ruta base de los dotfiles
DOTFILES="/home/diego/Di3go0-0_dots/Resources/wallpapers"

# Wallpaper a usar en todos los monitores
WALL="$DOTFILES/IMG0020.jpg"

# Generar hyprpaper.conf temporal
cat >/tmp/hyprpaper.conf <<EOF
preload = $WALL
EOF

# Detectar todos los monitores y asignarles el wallpaper
for MON in $(hyprctl monitors -j | jq -r '.[].name'); do
  echo "wallpaper = $MON,$WALL" >>/tmp/hyprpaper.conf
done

# Matar cualquier instancia previa
killall hyprpaper 2>/dev/null

# Iniciar hyprpaper con el conf generado
hyprpaper -c /tmp/hyprpaper.conf &
