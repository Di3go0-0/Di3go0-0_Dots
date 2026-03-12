#!/usr/bin/env sh

# Screenshot script for Ubuntu/Hyprland

XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
swpy_dir="$HOME/.config/swappy"
save_dir="$XDG_PICTURES_DIR/Screenshots"
save_file=$(date +'%d%m%y_%Hh%Mm%Ss_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p "$save_dir"
mkdir -p "$swpy_dir"

echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >"$swpy_dir/config"

function print_error
{
  cat <<"EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p  : print all screens + edit with swappy
        s  : snip current screen + edit with swappy
        sf : snip current screen (frozen) + edit with swappy
        m  : print focused monitor + edit with swappy
EOF
}

case $1 in
p) grim -o "$(hyprctl monitors -j | jq -r '.[0].name')" "$temp_screenshot" && swappy -f "$temp_screenshot" ;;
s) grim -g "$(slurp)" "$temp_screenshot" && swappy -f "$temp_screenshot" ;;
sf) grim -g "$(slurp -d)" "$temp_screenshot" && swappy -f "$temp_screenshot" ;;
m) grim -o "$(hyprctl monitors -j | jq -r '.[0].name')" "$temp_screenshot" && swappy -f "$temp_screenshot" ;;
*) print_error ;;
esac

rm -f "$temp_screenshot"

if [ -f "${save_dir}/${save_file}" ]; then
  notify-send -a "Screenshot" -i "${save_dir}/${save_file}" "Saved in ${save_dir}"
fi
