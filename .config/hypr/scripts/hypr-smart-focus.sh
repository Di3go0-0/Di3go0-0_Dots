#!/usr/bin/env bash
dir="$1"
is_full=$(hyprctl -j activewindow | jq -r '.fullscreen' 2>/dev/null)

if [[ "$is_full" == "2" ]]; then
  case "$dir" in
  h) hyprctl dispatch 'hl.dsp.window.cycle_next({ prev = true })' ;;
  l) hyprctl dispatch 'hl.dsp.window.cycle_next({ prev = true })' ;;
  k) hyprctl dispatch 'hl.dsp.window.cycle_next()' ;;
  j) hyprctl dispatch 'hl.dsp.window.cycle_next()' ;;
  esac
else
  case "$dir" in
  h) hyprctl dispatch 'hl.dsp.focus({ direction = "left" })' ;;
  l) hyprctl dispatch 'hl.dsp.focus({ direction = "right" })' ;;
  k) hyprctl dispatch 'hl.dsp.focus({ direction = "up" })' ;;
  j) hyprctl dispatch 'hl.dsp.focus({ direction = "down" })' ;;
  esac
fi
