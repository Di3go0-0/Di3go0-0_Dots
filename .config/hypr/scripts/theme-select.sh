#!/usr/bin/env bash
# theme-select.sh — menú rofi para cambiar theme (colors).
# Themes: DD01 (mauve), Glass Pink, Glass Blue, Auto from wallpaper.
# Usa wallust como templating engine (cs <name> aplica preset, run <img> auto-detecta).

set -u

STATE_FILE="$HOME/.cache/current-theme"
THEME_GLASS="$HOME/.config/rofi/themes/glass.rasi"

log() { printf '[theme-select] %s\n' "$*" >&2; }

# ---- subcomando: apply <theme-name> (sin menú, usado por autostart) ----
apply_theme() {
    local theme="$1" wallpaper

    case "$theme" in
        DD01|pink|blue|dracula)
            wallust cs "$theme" >/dev/null 2>&1
            ;;
        auto)
            # Sacar wallpaper actual del monitor focused (o el primero)
            wallpaper=$(awww query 2>/dev/null \
                | awk -F: 'NR==1 { gsub(/^[ ]+/,"",$NF); print $NF; exit }')
            if [[ -z "$wallpaper" || ! -f "$wallpaper" ]]; then
                notify-send -t 2200 "Theme" "No wallpaper detectado"
                return 1
            fi
            wallust run "$wallpaper" >/dev/null 2>&1
            ;;
        *)
            log "tema desconocido: $theme"; return 1
            ;;
    esac

    echo "$theme" > "$STATE_FILE"

    # Reloads
    pkill -SIGUSR2 waybar 2>/dev/null
    swaync-client --reload-css 2>/dev/null
    hyprctl reload >/dev/null 2>&1

    # Notif (kitty no recarga en vivo sin allow_remote_control → abrir ventana nueva)
    notify-send -t 2200 "Theme" "$theme aplicado (kitty: nueva ventana)"
}

if [[ "${1:-}" == "apply" ]]; then
    apply_theme "${2:?theme required}"
    exit 0
fi

# ---- menú normal ----
# Lee el theme activo para marcarlo
current=$(cat "$STATE_FILE" 2>/dev/null)

mark() {
    local key="$1" label="$2"
    if [[ "$key" == "$current" ]]; then
        printf '%s\n' "  $label   (current)"
    else
        printf '%s\n' "  $label"
    fi
}

options="$(mark DD01    'DD01  ·  mauve (default)')
$(mark pink    'Glass Pink')
$(mark blue    'Glass Blue')
$(mark dracula 'Glass Dracula')
$(mark auto    'Auto from wallpaper')"

sel=$(printf '%s\n' "$options" \
    | rofi -dmenu -i -p "Theme:" -theme "$HOME/.config/rofi/themes/wallpaper-scope.rasi")

case "$sel" in
    *"DD01"*)             apply_theme DD01 ;;
    *"Glass Pink"*)       apply_theme pink ;;
    *"Glass Blue"*)       apply_theme blue ;;
    *"Glass Dracula"*)    apply_theme dracula ;;
    *"Auto from wallpaper"*) apply_theme auto ;;
    "")                   exit 0 ;;
    *)                    log "selección no reconocida: $sel" ;;
esac
