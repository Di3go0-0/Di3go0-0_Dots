-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

--------------------------------
---- OPACITY RULES          ----
--------------------------------

-- Browsers
hl.window_rule({
    name  = "firefox-opacity",
    match = { class = "^(firefox)$" },
    opacity = "0.90 0.90 1",
})

hl.window_rule({
    name  = "brave-opacity",
    match = { class = "^(Brave-browser)$" },
    opacity = "0.90 0.90 1",
})

-- Code editors
hl.window_rule({
    name  = "code-oss-opacity",
    match = { class = "^(code-oss)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "code-opacity",
    match = { class = "^([Cc]ode)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "code-url-handler-opacity",
    match = { class = "^(code-url-handler)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "code-insiders-opacity",
    match = { class = "^(code-insiders-url-handler)$" },
    opacity = "0.80 0.80 1",
})

-- Terminal & file managers
hl.window_rule({
    name  = "kitty-opacity",
    match = { class = "^(kitty)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "dolphin-opacity",
    match = { class = "^(org.kde.dolphin)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "ark-opacity",
    match = { class = "^(org.kde.ark)$" },
    opacity = "0.80 0.80 1",
})

-- Settings & system
hl.window_rule({
    name  = "nwg-look-opacity",
    match = { class = "^(nwg-look)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "qt5ct-opacity",
    match = { class = "^(qt5ct)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "qt6ct-opacity",
    match = { class = "^(qt6ct)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "kvantum-opacity",
    match = { class = "^(kvantummanager)$" },
    opacity = "0.80 0.80 1",
})

hl.window_rule({
    name  = "pavucontrol-opacity",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "blueman-opacity",
    match = { class = "^(blueman-manager)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "nm-applet-opacity",
    match = { class = "^(nm-applet)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "nm-editor-opacity",
    match = { class = "^(nm-connection-editor)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "polkit-kde-opacity",
    match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "polkit-gnome-opacity",
    match = { class = "^(polkit-gnome-authentication-agent-1)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "portal-gtk-opacity",
    match = { class = "^(org.freedesktop.impl.portal.desktop.gtk)$" },
    opacity = "0.80 0.70 1",
})

hl.window_rule({
    name  = "portal-hyprland-opacity",
    match = { class = "^(org.freedesktop.impl.portal.desktop.hyprland)$" },
    opacity = "0.80 0.70 1",
})

-- Steam & entertainment
hl.window_rule({
    name  = "steam-opacity",
    match = { class = "^([Ss]team)$" },
    opacity = "0.70 0.70 1",
})

hl.window_rule({
    name  = "steamweb-opacity",
    match = { class = "^(steamwebhelper)$" },
    opacity = "0.70 0.70 1",
})

hl.window_rule({
    name  = "spotify-opacity",
    match = { class = "^([Ss]potify)$" },
    opacity = "0.70 0.70 1",
})

hl.window_rule({
    name  = "spotify-free-opacity",
    match = { initial_title = "^(Spotify Free)$" },
    opacity = "0.70 0.70 1",
})

hl.window_rule({
    name  = "spotify-premium-opacity",
    match = { initial_title = "^(Spotify Premium)$" },
    opacity = "0.70 0.70 1",
})

-- Apps with 0.90/0.90 opacity
hl.window_rule({
    name  = "clapper-opacity",
    match = { class = "^(com.github.rafostar.Clapper)$" },
    opacity = "0.90 0.90",
})

-- Apps with 0.80/0.80 opacity
local opacity_80_classes = {
    "com.github.tchx84.Flatseal",
    "hu.kramo.Cartridges",
    "com.obsproject.Studio",
    "gnome-boxes",
    "vesktop",
    "discord",
    "WebCord",
    "ArmCord",
    "app.drey.Warp",
    "net.davidotek.pupgui2",
    "yad",
    "Signal",
    "io.github.alainm23.planify",
    "io.gitlab.theevilskeleton.Upscaler",
    "com.github.unrud.VideoDownloader",
    "io.gitlab.adhami3310.Impression",
    "io.missioncenter.MissionCenter",
    "io.github.flattool.Warehouse",
}

for _, cls in ipairs(opacity_80_classes) do
    hl.window_rule({
        name  = cls:gsub("%.", "-") .. "-opacity",
        match = { class = "^(" .. cls .. ")$" },
        opacity = "0.80 0.80",
    })
end

--------------------------------
---- FLOAT RULES            ----
--------------------------------

local float_rules = {
    { class = "^(org.kde.dolphin)$",  title = "^(Progress Dialog — Dolphin)$" },
    { class = "^(org.kde.dolphin)$",  title = "^(Copying — Dolphin)$" },
    { title = "^(About Mozilla Firefox)$" },
    { class = "^(firefox)$",          title = "^(Picture-in-Picture)$" },
    { class = "^(firefox)$",          title = "^(Library)$" },
    { class = "^(kitty)$",            title = "^(top)$" },
    { class = "^(kitty)$",            title = "^(btop)$" },
    { class = "^(kitty)$",            title = "^(htop)$" },
    { class = "^(vlc)$" },
    { class = "^(kvantummanager)$" },
    { class = "^(qt5ct)$" },
    { class = "^(qt6ct)$" },
    { class = "^(nwg-look)$" },
    { class = "^(org.kde.ark)$" },
    { class = "^(org.pulseaudio.pavucontrol)$" },
    { class = "^(blueman-manager)$" },
    { class = "^(nm-applet)$" },
    { class = "^(nm-connection-editor)$" },
    { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
    { class = "^(Signal)$" },
    { class = "^(com.github.rafostar.Clapper)$" },
    { class = "^(app.drey.Warp)$" },
    { class = "^(net.davidotek.pupgui2)$" },
    { class = "^(yad)$" },
    { class = "^(eog)$" },
    { class = "^(io.github.alainm23.planify)$" },
    { class = "^(io.gitlab.theevilskeleton.Upscaler)$" },
    { class = "^(com.github.unrud.VideoDownloader)$" },
    { class = "^(io.gitlab.adhami3310.Impression)$" },
    { class = "^(io.missioncenter.MissionCenter)$" },
}

for i, rule in ipairs(float_rules) do
    hl.window_rule({
        name  = "float-rule-" .. i,
        match = rule,
        float = true,
    })
end

-- Common modals
hl.window_rule({
    name  = "float-open-file",
    match = { initial_title = "^(Open File)$" },
    float = true,
})

hl.window_rule({
    name  = "float-choose-files",
    match = { title = "^(Choose Files)$" },
    float = true,
})

hl.window_rule({
    name  = "float-save-as",
    match = { title = "^(Save As)$" },
    float = true,
})

hl.window_rule({
    name  = "float-confirm-replace",
    match = { title = "^(Confirm to replace files)$" },
    float = true,
})

hl.window_rule({
    name  = "float-file-progress",
    match = { title = "^(File Operation Progress)$" },
    float = true,
})

hl.window_rule({
    name  = "float-portal-gtk",
    match = { class = "^(xdg-desktop-portal-gtk)$" },
    float = true,
})

--------------------------------
---- LAYER RULES            ----
--------------------------------

-- Rofi
hl.layer_rule({
    name  = "rofi-blur",
    match = { namespace = "rofi" },
    blur  = true,
    ignore_alpha = 0.5,
})

-- Notifications
hl.layer_rule({
    name  = "notifications-blur",
    match = { namespace = "notifications" },
    blur  = true,
    ignore_alpha = 0.5,
})

-- SwayNC
hl.layer_rule({
    name  = "swaync-notification-blur",
    match = { namespace = "swaync-notification-window" },
    blur  = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name  = "swaync-control-blur",
    match = { namespace = "swaync-control-center" },
    blur  = true,
    ignore_alpha = 0.5,
})

-- Logout dialog
hl.layer_rule({
    name  = "logout-blur",
    match = { namespace = "logout_dialog" },
    blur  = true,
})
