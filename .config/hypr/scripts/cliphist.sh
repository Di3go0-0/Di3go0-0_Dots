#!/usr/bin/env sh

# Set variables
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh"
roconf="${confDir}/rofi/clipboard.rasi"
favoritesFile="${HOME}/.cliphist_favorites"

# Set rofi scaling
[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
r_scale="configuration {font: \"CaskaydiaCove Nerd Font ${rofiScale}\";}"
wind_border=$((hypr_border * 3 / 2))
elem_border=$([ $hypr_border -eq 0 ] && echo "5" || echo $hypr_border)

# Evaluate spawn position
readarray -t curPos < <(hyprctl cursorpos -j | jq -r '.x,.y')
readarray -t monRes < <(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width,.height,.scale,.x,.y')
readarray -t offRes < <(hyprctl -j monitors | jq -r '.[] | select(.focused==true).reserved | map(tostring) | join("\n")')
monRes[2]="$(echo "${monRes[2]}" | sed "s/\.//")"
monRes[0]="$(( ${monRes[0]} * 100 / ${monRes[2]} ))"
monRes[1]="$(( ${monRes[1]} * 100 / ${monRes[2]} ))"
curPos[0]="$(( ${curPos[0]} - ${monRes[3]} ))"
curPos[1]="$(( ${curPos[1]} - ${monRes[4]} ))"

if [ "${curPos[0]}" -ge "$((${monRes[0]} / 2))" ] ; then
    x_pos="east"
    x_off="-$(( ${monRes[0]} - ${curPos[0]} - ${offRes[2]} ))"
else
    x_pos="west"
    x_off="$(( ${curPos[0]} - ${offRes[0]} ))"
fi

if [ "${curPos[1]}" -ge "$((${monRes[1]} / 2))" ] ; then
    y_pos="south"
    y_off="-$(( ${monRes[1]} - ${curPos[1]} - ${offRes[3]} ))"
else
    y_pos="north"
    y_off="$(( ${curPos[1]} - ${offRes[1]} ))"
fi

r_override="window{location:${x_pos} ${y_pos};anchor:${x_pos} ${y_pos};x-offset:${x_off}px;y-offset:${y_off}px;border:${hypr_width}px;border-radius:${wind_border}px;} wallbox{border-radius:${elem_border}px;} element{border-radius:${elem_border}px;}"

# [GLASS] Pipe que añade thumbnails + label limpio a entries de imagen.
# Genera thumbs en ~/.cache/cliphist-thumbs/ (cacheados por id).
# Reemplaza "[[ binary data X KiB png WxH ]]" por "PNG · 579×451 · 191 KiB".
cliphist_with_thumbs() {
    local cache="$HOME/.cache/cliphist-thumbs"
    mkdir -p "$cache"

    # Limpieza: borrar thumbs cuyo id ya no esté en cliphist
    local valid_ids
    valid_ids=$(cliphist list | cut -f1)
    for thumb in "$cache"/*.png; do
        [[ -f "$thumb" ]] || continue
        local tid="${thumb##*/}"; tid="${tid%.png}"
        grep -qx "$tid" <<< "$valid_ids" || rm -f "$thumb"
    done

    cliphist list | while IFS=$'\t' read -r id preview; do
        # Detectar entries de imagen: "[[ binary data SIZE UNIT FMT WxH ]]"
        if [[ "$preview" =~ \[\[\ binary\ data\ ([0-9.]+)\ (B|KiB|MiB|GiB)\ (png|jpg|jpeg|webp|gif|bmp)(\ ([0-9]+)x([0-9]+))?\ \]\] ]]; then
            local size="${BASH_REMATCH[1]} ${BASH_REMATCH[2]}"
            local fmt="${BASH_REMATCH[3]^^}"   # uppercase
            local w="${BASH_REMATCH[5]}"
            local h="${BASH_REMATCH[6]}"

            local label
            if [[ -n "$w" ]]; then
                label="$fmt  ·  ${w}×${h}  ·  $size"
            else
                label="$fmt  ·  $size"
            fi

            local thumb="$cache/$id.png"
            if [[ ! -f "$thumb" ]]; then
                cliphist decode "$id" | magick - -thumbnail 96x96 "$thumb" 2>/dev/null || {
                    printf '%s\t%s\n' "$id" "$preview"
                    continue
                }
            fi
            printf '%s\t%s\0icon\x1f%s\n' "$id" "$label" "$thumb"
        else
            printf '%s\t%s\n' "$id" "$preview"
        fi
    done
}

# [GLASS] Helper para favorites: maneja imagenes (binarias) via temp file + mime detection.
# Sin esto, base64 -d en variable bash trunca en null byte y rofi recibe basura -> cuelgue.
# Emite por stdout: 1 entrada por favorito con icono si es imagen, ID secuencial, label limpio.
# Stderr: para cada favorito, "is_image:base64line" — usado por el caller para resolver índice.
favorites_with_thumbs() {
    local cache="$HOME/.cache/cliphist-fav-thumbs"
    mkdir -p "$cache"
    [[ -f "$favoritesFile" && -s "$favoritesFile" ]] || return

    local i=0 fav_b64 tmp mime hash thumb size_b kib fmt text
    while IFS= read -r fav_b64; do
        i=$((i+1))
        tmp=$(mktemp /tmp/cliphist-fav-XXXX)
        printf '%s' "$fav_b64" | base64 --decode > "$tmp" 2>/dev/null

        mime=$(file --mime-type -b "$tmp" 2>/dev/null)

        if [[ "$mime" == image/* ]]; then
            hash=$(printf '%s' "$fav_b64" | sha1sum | cut -d' ' -f1)
            thumb="$cache/$hash.png"
            [[ -f "$thumb" ]] || magick "$tmp" -thumbnail 96x96 "$thumb" 2>/dev/null
            size_b=$(stat -c%s "$tmp" 2>/dev/null)
            kib=$((size_b / 1024))
            fmt=$(echo "$mime" | cut -d/ -f2 | tr '[:lower:]' '[:upper:]')
            if [[ -f "$thumb" ]]; then
                printf '%4d\t%s  ·  %s KiB\0icon\x1f%s\n' "$i" "$fmt" "$kib" "$thumb"
            else
                printf '%4d\t[Image %s · %s KiB]\n' "$i" "$fmt" "$kib"
            fi
        elif [[ "$mime" == application/octet-stream ]] || [[ "$mime" == application/* ]]; then
            # Binary corrupto (probablemente imagen mal agregada por null-truncation)
            size_b=$(stat -c%s "$tmp" 2>/dev/null)
            kib=$((size_b / 1024))
            printf '%4d\t[Binary corrupto · %s KiB — borrar desde Manage > Delete]\n' "$i" "$kib"
        else
            text=$(tr '\n' ' ' < "$tmp" | head -c 200)
            printf '%4d\t%s\n' "$i" "$text"
        fi
        rm -f "$tmp"
    done < "$favoritesFile"
}

# Show main menu if no arguments are passed
if [ $# -eq 0 ]; then
    main_action=$(echo -e "History\nDelete\nView Favorites\nManage Favorites\nClear History" | rofi -dmenu -theme-str "entry { placeholder: \"Choose action\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
else
    main_action="History"
fi

case "${main_action}" in
"History")
    selected_item=$(cliphist_with_thumbs | rofi -dmenu -show-icons -theme-str "entry { placeholder: \"History...\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
    if [ -n "$selected_item" ]; then
        echo "$selected_item" | cliphist decode | wl-copy
        notify-send "Copied to clipboard."
    fi
    ;;
"Delete")
    selected_item=$(cliphist_with_thumbs | rofi -dmenu -show-icons -theme-str "entry { placeholder: \"Delete...\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
    if [ -n "$selected_item" ]; then
        echo "$selected_item" | cliphist delete
        notify-send "Deleted."
    fi
    ;;
"View Favorites")
    if [ -f "$favoritesFile" ] && [ -s "$favoritesFile" ]; then
        # [GLASS] Usa favorites_with_thumbs (maneja imágenes via mime + thumbnail).
        selected_favorite=$(favorites_with_thumbs | rofi -dmenu -show-icons -theme-str "entry { placeholder: \"View Favorites\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
        if [ -n "$selected_favorite" ]; then
            # [GLASS] El ID está en el primer "campo" tab-separated (formato "  N\tlabel")
            index=$(printf '%s' "$selected_favorite" | awk -F'\t' '{print $1}' | tr -d ' ')
            mapfile -t favorites < "$favoritesFile"
            if [[ -n "$index" && "$index" =~ ^[0-9]+$ && "$index" -ge 1 && "$index" -le "${#favorites[@]}" ]]; then
                selected_encoded_favorite="${favorites[$((index - 1))]}"
                echo "$selected_encoded_favorite" | base64 --decode | wl-copy
                notify-send "Copied to clipboard."
            else
                notify-send "Error: Selected favorite not found."
            fi
        fi
    else
        notify-send "No favorites."
    fi
    ;;
"Manage Favorites")
    manage_action=$(echo -e "Add to Favorites\nDelete from Favorites\nClear All Favorites" | rofi -dmenu -theme-str "entry { placeholder: \"Manage Favorites\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")

    case "${manage_action}" in
    "Add to Favorites")
        # Show clipboard history to add to favorites
        item=$(cliphist_with_thumbs | rofi -dmenu -show-icons -theme-str "entry { placeholder: \"Add to Favorites...\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
        if [ -n "$item" ]; then
            # [GLASS] Decode + encode via temp file (NO via variable bash, que trunca
            # en null bytes y corrompe imágenes — bug que dejó favoritos basura).
            tmp_fav=$(mktemp /tmp/cliphist-add-XXXX)
            echo "$item" | cliphist decode > "$tmp_fav"
            encoded_item=$(base64 -w 0 "$tmp_fav")
            rm -f "$tmp_fav"

            # Check if the item is already in the favorites file
            if grep -Fxq "$encoded_item" "$favoritesFile"; then
                notify-send "Item is already in favorites."
            else
                # Add the encoded item to the favorites file
                echo "$encoded_item" >> "$favoritesFile"
                notify-send "Added in favorites."
            fi
        fi
        ;;
    "Delete from Favorites")
        if [ -f "$favoritesFile" ] && [ -s "$favoritesFile" ]; then
            # Read each Base64 encoded favorite as a separate line
            # [GLASS] Usa favorites_with_thumbs (maneja imágenes via mime + thumbnail).
            selected_favorite=$(favorites_with_thumbs | rofi -dmenu -show-icons -theme-str "entry { placeholder: \"Remove from Favorites...\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
            if [ -n "$selected_favorite" ]; then
                index=$(printf '%s' "$selected_favorite" | awk -F'\t' '{print $1}' | tr -d ' ')
                mapfile -t favorites < "$favoritesFile"
                if [[ -n "$index" && "$index" =~ ^[0-9]+$ && "$index" -ge 1 && "$index" -le "${#favorites[@]}" ]]; then
                    selected_encoded_favorite="${favorites[$((index - 1))]}"

                    # Handle case where only one item is present
                    if [ "$(wc -l < "$favoritesFile")" -eq 1 ]; then
                        # Remove the single encoded item from the file
                        > "$favoritesFile"
                    else
                        # Remove the selected encoded item from the favorites file
                        grep -vF -x "$selected_encoded_favorite" "$favoritesFile" > "${favoritesFile}.tmp" && mv "${favoritesFile}.tmp" "$favoritesFile"
                    fi
                    notify-send "Item removed from favorites."
                else
                    notify-send "Error: Selected favorite not found."
                fi
            fi
        else
            notify-send "No favorites to remove."
        fi
        ;;
    "Clear All Favorites")
        if [ -f "$favoritesFile" ] && [ -s "$favoritesFile" ]; then
            confirm=$(echo -e "Yes\nNo" | rofi -dmenu -theme-str "entry { placeholder: \"Clear All Favorites?\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")
            if [ "$confirm" = "Yes" ]; then
                > "$favoritesFile"
                notify-send "All favorites have been deleted."
            fi
        else
            notify-send "No favorites to delete."
        fi
        ;;
        *)
            echo "Invalid action"
            exit 1
            ;;
        esac
        ;;
"Clear History")
    if [ "$(echo -e "Yes\nNo" | rofi -dmenu -theme-str "entry { placeholder: \"Clear Clipboard History?\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}")" == "Yes" ] ; then
        cliphist wipe
        notify-send "Clipboard history cleared."
    fi
    ;;
*)
    echo "Invalid action"
    exit 1
    ;;
esac
