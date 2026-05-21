#!/bin/bash
# Smart close: minimize Spotify to tray, kill other windows
class=$(hyprctl activewindow | grep "class:" | cut -d' ' -f2)
if [[ "${class,,}" == "spotify" ]]; then
	hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:spotify", silent = true })'
else
	hyprctl dispatch 'hl.dsp.window.close()'
fi
