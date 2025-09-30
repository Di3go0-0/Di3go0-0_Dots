#!/usr/bin/env bash

# Carpeta de wallpapers
WALLPAPER_DIR="$HOME/Di3go0-0_dots/Resources/wallpapers"

# Elegir uno al azar
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

# Ruta del archivo de Hyprlock principal
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

# Archivo temporal con la variable actualizada
TMP_CONF=$(mktemp)

# Reemplazar la línea de $BACKGROUND en hyprlock.conf
sed "s|^\$BACKGROUND = .*|\$BACKGROUND = $RANDOM_WALLPAPER|" "$HYPRLOCK_CONF" >"$TMP_CONF"

# Sobrescribir hyprlock.conf
mv "$TMP_CONF" "$HYPRLOCK_CONF"

# Ejecutar Hyprlock
exec hyprlock
