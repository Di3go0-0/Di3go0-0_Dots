-- ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
-- ██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local lf          = "lf"
local DB          = "~/.cargo/bin/dbtui"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local window      = "rofi -show window"
local explorer    = "dolphin"
local scriptpath  = os.getenv("HOME") .. "/Di3go0-0_dots/.config/hypr/scripts/"
local browser     = "google-chrome-stable"
local termFM      = "ranger"

local mainMod = "SUPER"

-----------------------
---- APP LAUNCHERS ----
-----------------------

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(terminal .. " -e " .. lf))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(terminal .. " -e " .. DB))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(explorer))
hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd(terminal .. " -e " .. termFM))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))

----------------------------
---- WINDOW MANAGEMENT  ----
----------------------------

-- SUPER+Q usa smart-close.sh (integrado desde spotify.conf)
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.config/hypr/UserScripts/smart-close.sh"))
hl.bind(mainMod .. " + Delete", hl.dsp.exit())
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + X", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + M", hl.dsp.layout("togglesplit"))
hl.bind("ALT + space", hl.dsp.window.fullscreen())

------------------------
---- SCREENSHOTS    ----
------------------------

hl.bind("PRINT", hl.dsp.exec_cmd(scriptpath .. "screenshot.sh p"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scriptpath .. "screenshot.sh sf"))

------------------------
---- FOCUS          ----
------------------------

-- Arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Vim-style focus (smart focus scripts)
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(scriptpath .. "hypr-smart-focus.sh h"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(scriptpath .. "hypr-smart-focus.sh l"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd(scriptpath .. "hypr-smart-focus.sh j"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(scriptpath .. "hypr-smart-focus.sh k"))

------------------------
---- WORKSPACES     ----
------------------------

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

----------------------------
---- SWAP / MOVE WINDOW ----
----------------------------

-- Swap window position
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "down" }))

-- Move floating windows
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ direction = "down" }))

-- Center floating window
hl.bind(mainMod .. " + ALT + C", hl.dsp.window.center())

-- Resize windows
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 40,  y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0,   y = -40, relative = true }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0,   y = 40, relative = true }))

----------------------------
---- MEDIA KEYS         ----
----------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),     { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),     { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),  { locked = true, repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media player (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

----------------------------
---- CUSTOM SCRIPTS     ----
----------------------------

hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("pkill -x rofi || " .. scriptpath .. "cliphist.sh c"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pkill -x rofi || " .. scriptpath .. "cliphist.sh"))
hl.bind(mainMod .. " + TAB",       hl.dsp.exec_cmd(scriptpath .. "waybar-restart.sh"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(scriptpath .. "logoutlaunch.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("killall hyprpaper && hyprpaper"))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("kitty -e sudo pacman -Syu"))

----------------------------
---- MOUSE BINDS        ----
----------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
