#!/usr/bin/env sh

# Hyprland screenshot pipeline:
#   grimblast captures -> hyprshade restored -> swappy opens for annotation
#   -> on save, swappy writes directly to ~/Pictures/Screenshots/<date>.png
#
# Swappy config lives in ~/.config/swappy/config and is NOT overwritten here;
# the save path is forced per-run via --output-file so the persistent config
# (fonts, line sizes, paint mode) stays intact.

# Restores the shader after screenshot has been taken
restore_shader() {
  if [ -n "$shader" ]; then
    hyprshade on "$shader"
  fi
}

# Saves the current shader and turns it off
save_shader() {
  shader=$(hyprshade current)
  hyprshade off
  trap restore_shader EXIT
}

save_shader

XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
save_dir="$XDG_PICTURES_DIR/Screenshots"
save_file=$(date +'%Y%m%d-%Hh%Mm%Ss').png
save_path="$save_dir/$save_file"
temp_screenshot="/tmp/screenshot.png"

mkdir -p "$save_dir"

annotate() {
  # $1 = source PNG, opens swappy and forces output path
  swappy -f "$1" --output-file "$save_path"
  rm -f -- "$1"
  if [ -f "$save_path" ]; then
    # also stash final image to clipboard
    wl-copy --type image/png <"$save_path" 2>/dev/null
    notify-send -a "screenshot" -i "$save_path" \
      "Screenshot saved" "$save_file"
  fi
}

copy_only() {
  # No annotation flow — just grab & copy
  case $1 in
    area)    grimblast copy area ;;
    screen)  grimblast copy screen ;;
    output)  grimblast copy output ;;
  esac
  notify-send -a "screenshot" "Copied to clipboard" "$1"
}

print_error() {
  cat <<'EOF'
    screenshot.sh <action>
    ...valid actions are...
        p   : full screen  -> annotate
        s   : area         -> annotate
        sf  : area frozen  -> annotate
        m   : focused monitor -> annotate
        cp  : full screen   -> clipboard only
        cs  : area          -> clipboard only
        cm  : focused mon   -> clipboard only
EOF
}

case $1 in
  p)  grimblast copysave screen "$temp_screenshot" && restore_shader && annotate "$temp_screenshot" ;;
  s)  grimblast copysave area   "$temp_screenshot" && restore_shader && annotate "$temp_screenshot" ;;
  sf) grimblast --freeze copysave area "$temp_screenshot" && restore_shader && annotate "$temp_screenshot" ;;
  m)  grimblast copysave output "$temp_screenshot" && restore_shader && annotate "$temp_screenshot" ;;
  cp) copy_only screen ;;
  cs) copy_only area ;;
  cm) copy_only output ;;
  *)  print_error ;;
esac
