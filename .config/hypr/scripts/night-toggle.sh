#!/usr/bin/env bash
# night-toggle.sh — toggle blue-light-filter usando el shader de hyprshade.
# Funciona en Hyprland 0.55 (Lua config) donde `hyprshade on/off/toggle` está roto
# (intenta usar `hyprctl keyword` que ya no soporta parsers no-legacy).
#
# Usage:
#   night-toggle.sh         → toggle on/off
#   night-toggle.sh on      → activar
#   night-toggle.sh off     → desactivar

set -u

SHADER="$HOME/.config/hypr/shaders/blue-light-soft.glsl"

set_shader() {
  # NOTA: hyprctl dispatch con hl.config() imprime un error cosmético
  # ("expected a dispatcher") pero la config SÍ se aplica. Silenciamos.
  hyprctl dispatch "hl.config({ decoration = { screen_shader = \"$1\" } })" \
    >/dev/null 2>&1 || true
  # El shader solo afecta píxeles que se repintan. Forzar reload del renderer
  # para que se aplique inmediatamente sin tener que mover el mouse.
  hyprctl dispatch force_renderer_reload >/dev/null 2>&1 || true
}

current=$(hyprctl getoption decoration:screen_shader -j 2>/dev/null | jq -r '.str')

case "${1:-toggle}" in
  on)
    set_shader "$SHADER"
    ;;
  off)
    set_shader ""
    ;;
  toggle)
    if [[ -n "$current" ]]; then
      set_shader ""
      notify-send -t 1800 "Blue Light Filter" "OFF"
    else
      set_shader "$SHADER"
      notify-send -t 1800 "Blue Light Filter" "ON"
    fi
    ;;
  *)
    echo "uso: $0 [on|off|toggle]" >&2
    exit 1
    ;;
esac
