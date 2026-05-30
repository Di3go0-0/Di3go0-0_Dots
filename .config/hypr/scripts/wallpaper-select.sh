#!/usr/bin/env bash
# wallpaper-select.sh — visual wallpaper selector (rofi + awww).
# 3 modes navigable with Tab/Shift+Tab: Recent, Folders, All.

set -u

# ---- config ----
WP_BASE="$HOME/Di3go0-0_dots/Resources/wallpapers"
RECENTS_FILE="$HOME/.cache/wallpaper-recent"
RECENTS_MAX=24

CACHE="$HOME/.cache/wallpaper-thumbs"
THUMB_SIZE="380x250"

TRANSITION_TYPE="grow"
TRANSITION_FPS="60"
TRANSITION_DURATION="1.0"

THEME_SELECT="$HOME/.config/rofi/themes/wallpaper-select.rasi"
THEME_SCOPE="$HOME/.config/rofi/themes/wallpaper-scope.rasi"

SELF="$(readlink -f "$0")"

LOG=/tmp/wallpaper-select.log

log() { printf '[wallpaper-select] %s\n' "$*" >&2; }

# ---- helpers ----
gen_thumb() {
  local img="$1" key thumb
  key="$(printf '%s' "$img" | sha1sum | cut -d' ' -f1)"
  thumb="$CACHE/${key}.jpg"
  if [[ ! -f "$thumb" || "$img" -nt "$thumb" ]]; then
    magick "$img" -auto-orient -thumbnail "${THUMB_SIZE}^" \
      -gravity center -extent "$THUMB_SIZE" -quality 82 "$thumb" 2>/dev/null \
      || return 1
  fi
  printf '%s\n' "$thumb"
}

# Emite UNA entry de imagen con icon+info. Usa printf bash (awk no soporta \0).
emit_image_entry() {
  local img="$1" thumb label
  [[ -f "$img" ]] || return 0
  thumb="$(gen_thumb "$img")" || return 0
  label="${img##*/}"; label="${label%.*}"
  printf '%s\0icon\x1f%s\x1finfo\x1fIMG:%s\n' "$label" "$thumb" "$img"
}

list_imgs_in() {
  find "$1" -maxdepth 4 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
       -o -iname '*.webp' -o -iname '*.gif' \) -print0 2>/dev/null
}

add_to_recents() {
  local img="$1"
  mkdir -p "$(dirname "$RECENTS_FILE")"
  {
    printf '%s\n' "$img"
    [[ -f "$RECENTS_FILE" ]] && grep -vFx "$img" "$RECENTS_FILE"
  } | head -n "$RECENTS_MAX" > "${RECENTS_FILE}.tmp"
  mv "${RECENTS_FILE}.tmp" "$RECENTS_FILE"
}

apply_wallpaper() {
  local img="$1" scope
  scope=$(printf 'All monitors\nCurrent monitor only\n' \
    | rofi -dmenu -i -p "Apply to:" -theme "$THEME_SCOPE")
  [[ -z "$scope" ]] && return 0

  _apply() {
    awww img -o "$1" "$img" \
      --transition-type "$TRANSITION_TYPE" \
      --transition-fps "$TRANSITION_FPS" \
      --transition-duration "$TRANSITION_DURATION"
  }

  case "$scope" in
    "All monitors")
      mapfile -t MONS < <(hyprctl monitors -j | jq -r '.[].name')
      for m in "${MONS[@]}"; do _apply "$m"; done
      ;;
    "Current monitor only")
      _apply "$(hyprctl activeworkspace -j | jq -r '.monitor')"
      ;;
  esac

  add_to_recents "$img"
  notify-send -t 2200 "Wallpaper" "${img##*/}"
}

# ---- modes ----
mode_recent() {
  if [[ ! -s "$RECENTS_FILE" ]]; then
    printf '%s\0nonselectable\x1ftrue\n' "(no recent — pick one from Folders or All)"
    return
  fi
  while IFS= read -r img; do
    [[ -n "$img" && -f "$img" ]] && emit_image_entry "$img"
  done < "$RECENTS_FILE"
}

mode_folders() {
  # Coming from picking a folder → show its images + "← Back"
  if [[ "${ROFI_INFO:-}" == FOLDER:* ]]; then
    local folder="${ROFI_INFO#FOLDER:}"
    printf '%s\0info\x1fBACK\n' "← Back"
    while IFS= read -r -d '' img; do
      emit_image_entry "$img"
    done < <(list_imgs_in "$WP_BASE/$folder")
    return
  fi
  # Default state (initial or BACK): list folders with thumb of first image
  local d name first_img thumb
  for d in "$WP_BASE"/*/; do
    [[ -d "$d" ]] || continue
    name="${d%/}"; name="${name##*/}"
    first_img="$(find "$d" -maxdepth 4 -type f \
      \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
      2>/dev/null | head -n1)"
    thumb=""
    [[ -n "$first_img" ]] && thumb="$(gen_thumb "$first_img" 2>/dev/null || true)"
    if [[ -n "$thumb" ]]; then
      printf '%s\0icon\x1f%s\x1finfo\x1fFOLDER:%s\n' "$name" "$thumb" "$name"
    else
      printf '%s\0info\x1fFOLDER:%s\n' "$name" "$name"
    fi
  done
}

mode_all() {
  local d
  for d in "$WP_BASE"/*/; do
    [[ -d "$d" ]] || continue
    while IFS= read -r -d '' img; do
      emit_image_entry "$img"
    done < <(list_imgs_in "$d")
  done
}

# ---- dispatch script-mode (rofi llama al script) ----
if [[ "${1:-}" == "__mode" ]]; then
  mkdir -p "$CACHE"
  mode_name="${2:?modo requerido}"

  {
    echo "=== $(date) === ROFI_RETV=${ROFI_RETV:-?} ROFI_INFO='${ROFI_INFO:-}' mode=$mode_name argv3='${3:-}'"
  } >> "$LOG" 2>&1

  # Selección de una imagen → fork apply + exit (rofi cierra al no recibir entries)
  if [[ "${ROFI_INFO:-}" == IMG:* ]]; then
    img="${ROFI_INFO#IMG:}"
    nohup "$SELF" apply "$img" </dev/null >/dev/null 2>&1 &
    disown
    exit 0
  fi

  case "$mode_name" in
    Recent)  mode_recent ;;
    Folders) mode_folders ;;
    All)     mode_all ;;
    *) log "unknown mode: $mode_name"; exit 1 ;;
  esac
  exit 0
fi

# ---- internal subcommand: apply (forked after selection) ----
if [[ "${1:-}" == "apply" ]]; then
  apply_wallpaper "${2:?path required}"
  exit 0
fi

# ---- user invocation (no args) ----
for cmd in awww rofi magick jq hyprctl notify-send; do
  command -v "$cmd" >/dev/null || { notify-send "wallpaper-select" "Missing: $cmd"; exit 1; }
done

pkill -x hyprpaper 2>/dev/null && log "hyprpaper stopped"
if ! pgrep -x awww-daemon >/dev/null; then
  awww-daemon >/dev/null 2>&1 &
  sleep 0.4
fi

mkdir -p "$CACHE"

# Initial mode: Recent if any, otherwise All
INITIAL_MODE="All"
[[ -s "$RECENTS_FILE" ]] && INITIAL_MODE="Recent"

rofi -show "$INITIAL_MODE" \
  -modes "Recent:$SELF __mode Recent,Folders:$SELF __mode Folders,All:$SELF __mode All" \
  -theme "$THEME_SELECT" \
  -kb-element-next "" \
  -kb-element-prev "" \
  -kb-mode-next "Tab" \
  -kb-mode-previous "ISO_Left_Tab"
