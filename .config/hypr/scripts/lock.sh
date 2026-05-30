#!/usr/bin/env bash
# lock.sh — escoge wallpaper random y lanza hyprlock.
# El wallpaper se symlinkea a ~/.cache/hyprlock-wallpaper y el hyprlock.conf
# lo lee desde ahí. Así cada bloqueo muestra una imagen distinta.

set -u

WP_BASE="$HOME/Di3go0-0_dots/Resources/wallpapers"
SYMLINK="$HOME/.cache/hyprlock-wallpaper"

# Random pick recursivo (todas las carpetas, todas las imágenes)
random_wp=$(find "$WP_BASE" -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    2>/dev/null | shuf -n 1)

if [[ -n "$random_wp" && -f "$random_wp" ]]; then
    ln -sf "$random_wp" "$SYMLINK"
else
    # Fallback: cualquier imagen del primer monitor en awww
    awww query 2>/dev/null | awk -F: 'NR==1 { gsub(/^[ ]+/,"",$NF); print $NF }' \
        | xargs -I{} ln -sf "{}" "$SYMLINK" 2>/dev/null
fi

exec hyprlock "$@"
