#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WALLPAPERS_DIR="$HOME/Pictures/wallpapers"

WALL="$WALLPAPERS_DIR/general/IMG0020.jpg"

if [ ! -f "$WALL" ]; then
    echo "Wallpaper not found: $WALL"
    exit 1
fi

cat >/tmp/hyprpaper.conf <<EOF
preload = $WALL
EOF

for MON in $(hyprctl monitors -j | jq -r '.[].name'); do
    echo "wallpaper = $MON,$WALL" >>/tmp/hyprpaper.conf
done

killall hyprpaper 2>/dev/null

hyprpaper -c /tmp/hyprpaper.conf &
