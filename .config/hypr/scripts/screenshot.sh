#!/usr/bin/env sh

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

save_shader # Saving the current shader

# Definición de rutas segura
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
swpy_dir="$HOME/.config/swappy"
save_dir="$XDG_PICTURES_DIR/Screenshots"
save_file=$(date +'%d%m%y_%Hh%Mm%Ss_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

# Crear directorios si no existen
mkdir -p "$save_dir"
mkdir -p "$swpy_dir"

# Configurar Swappy para que guarde automáticamente en la ruta deseada
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >"$swpy_dir/config"

function print_error
{
  cat <<"EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p  : print all screens
        s  : snip current screen
        sf : snip current screen (frozen)
        m  : print focused monitor
EOF
}

case $1 in
p) grimblast copysave screen $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
s) grimblast copysave area $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
sf) grimblast --freeze copysave area $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
m) grimblast copysave output $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
*) print_error ;;
esac

rm "$temp_screenshot"

if [ -f "${save_dir}/${save_file}" ]; then
  notify-send -a "t1" -i "${save_dir}/${save_file}" "saved in ${save_dir}"
fi
