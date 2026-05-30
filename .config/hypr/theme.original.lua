-- Theme: Catppuccin Mocha Custom

-- Theme metadata (from wallbash.conf)
local theme = {
    name            = "Catppuccin Mocha Custom",
    gtk             = "Catppuccin-Mocha",
    icon            = "Tela-circle-dracula",
    color_scheme    = "prefer-dark",
    cursor_theme    = "Bibata-Modern-Ice",
    cursor_size     = 24,
    font            = "Cantarell",
    font_size       = 10,
    document_font   = "Cantarell",
    document_font_size = 10,
    monospace_font  = "CaskaydiaCove Nerd Font Mono",
    monospace_font_size = 9,
    code_theme      = "Wallbash",
}

-- Wallbash color palette (from colors.conf)
local colors = {
    -- Color group 1
    pry1 = "1B1A29",    txt1 = "FFFFFF",
    _1xa1 = "2C2952",   _1xa2 = "3D3A6B",   _1xa3 = "4E4B7D",
    _1xa4 = "5B578F",   _1xa5 = "6965A3",   _1xa6 = "7F7AC2",
    _1xa7 = "9F9AE6",   _1xa8 = "AFAAF0",   _1xa9 = "CFCCFF",

    -- Color group 2
    pry2 = "272E3C",    txt2 = "FFFFFF",
    _2xa1 = "293652",   _2xa2 = "3A4A6B",   _2xa3 = "4B5C7D",
    _2xa4 = "576A8F",   _2xa5 = "657AA3",   _2xa6 = "7A92C2",
    _2xa7 = "9AB3E6",   _2xa8 = "AAC1F0",   _2xa9 = "CCDDFF",

    -- Color group 3
    pry3 = "2D4E5B",    txt3 = "FFFFFF",
    _3xa1 = "294652",   _3xa2 = "3A5D6B",   _3xa3 = "4B6F7D",
    _3xa4 = "577F8F",   _3xa5 = "6592A3",   _3xa6 = "7AAEC2",
    _3xa7 = "9AD0E6",   _3xa8 = "AADCF0",   _3xa9 = "CCF1FF",

    -- Color group 4
    pry4 = "974C4E",    txt4 = "FFFFFF",
    _4xa1 = "52292A",   _4xa2 = "6B3A3B",   _4xa3 = "7D4B4C",
    _4xa4 = "8F5759",   _4xa5 = "A36567",   _4xa6 = "C27A7C",
    _4xa7 = "E69A9C",   _4xa8 = "F0AAAC",   _4xa9 = "FFCCCD",
}

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 3,
        border_size = 1,
        col = {
            active_border   = { colors = {"rgba(ca9ee680)", "rgba(f2d5cf80)"}, angle = 45 },
            inactive_border = { colors = {"rgba(b4befe60)", "rgba(6c708660)"}, angle = 45 },
        },
        layout = "dwindle",
        resize_on_border = true,
    },

    group = {
        col = {
            border_active          = { colors = {"rgba(ca9ee6ff)", "rgba(f2d5cfff)"}, angle = 45 },
            border_inactive        = { colors = {"rgba(b4befecc)", "rgba(6c7086cc)"}, angle = 45 },
            border_locked_active   = { colors = {"rgba(ca9ee6ff)", "rgba(f2d5cfff)"}, angle = 45 },
            border_locked_inactive = { colors = {"rgba(b4befecc)", "rgba(6c7086cc)"}, angle = 45 },
        },
    },

    decoration = {
        rounding = 10,
        active_opacity = 1,
        inactive_opacity = 0.85,

        shadow = { enabled = false },

        blur = {
            enabled          = true,
            size             = 8,
            passes           = 2,
            ignore_opacity   = true,
            contrast         = 1.8,
            xray             = false,
            new_optimizations = true,
        },
    },

    dwindle = {
        preserve_split = true,
    },
})
