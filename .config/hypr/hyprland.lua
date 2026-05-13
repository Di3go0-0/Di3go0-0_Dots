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
    hl.exec_cmd("waybar & swaync & hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprpaper --config /home/diego/Di3go0-0_dots/.config/hypr/hyprpaper.conf")
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
