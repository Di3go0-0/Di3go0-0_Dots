-- ██████╗ ██╗██████╗  ██████╗  ██████╗  ██████╗        ██████╗
-- ██╔══██╗██║╚════██╗██╔════╝ ██╔═══██╗██╔═████╗      ██╔═████╗
-- ██║  ██║██║ █████╔╝██║  ███╗██║   ██║██║██╔██║█████╗██║██╔██║
-- ██║  ██║██║ ╚═══██╗██║   ██║██║   ██║████╔╝██║╚════╝████╔╝██║
-- ██████╔╝██║██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝      ╚██████╔╝
-- ╚═════╝ ╚═╝╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝        ╚═════╝

-- Modules
require("theme")
require("animations")

-- Fix multi-GPU cursor blit (Intel + NVIDIA)
hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

require("monitors")
require("keybindings")
require("windowrules")
require("spotify")

--------------------
---- AUTOSTART  ----
--------------------

hl.on("hyprland.start", function()
    -- Daemons que no dependen de hyprctl
    hl.exec_cmd("swaync & hypridle")
    -- [NIGHT-TOGGLE] hyprsunset no estaba instalado. hyprshade tampoco funciona en Lua config (usa hyprctl keyword).
    -- hl.exec_cmd("hyprsunset")
    -- hl.exec_cmd("hyprshade on blue-light-filter")  -- NO funciona en 0.55
    hl.exec_cmd("bash $HOME/.config/hypr/scripts/night-toggle.sh on")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- [WALLPAPER-SELECT] motor awww (paquete swww). Reemplaza hyprpaper.
    -- hl.exec_cmd("hyprpaper --config /home/diego/Di3go0-0_dots/.config/hypr/hyprpaper.conf")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep 0.4 && (awww restore || awww img " ..
        "'/home/diego/Di3go0-0_dots/Resources/wallpapers/Japoneses/osaka.jpg')")
    -- [WALLUST] Theme PRIMERO (genera colors-wallust.css que waybar necesita).
    -- Luego waybar, esperando a que hyprctl responda (evita carga "vacía").
    hl.exec_cmd("bash $HOME/.config/hypr/scripts/theme-select.sh apply " ..
        "\"$(cat $HOME/.cache/current-theme 2>/dev/null || echo DD01)\" && " ..
        "(until hyprctl monitors >/dev/null 2>&1; do sleep 0.1; done; waybar) &")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-----------------
---- XWAYLAND ---
-----------------

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

--------------------
---- LAYER RULES ---
--------------------

-- [GLASS] Blur de fondo para rofi (glassmorphism). Sin esto el alpha translúcido
-- solo deja ver el escritorio crudo, no la versión blureada.
hl.layer_rule({ match = "rofi", blur = true, ignore_alpha = true })
