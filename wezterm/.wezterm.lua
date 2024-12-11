-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#dcd7ba",
		background = "#181616",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.window_padding = {
	top = 8,
	right = 8,
	left = 8,
	bottom = 8,
}
config.force_reverse_video_cursor = true
config.colors = {}
config.colors.foreground = "#dcd7ba"
config.colors.background = "#181616"
config.colors.cursor_bg = "#c8c093"
config.colors.cursor_fg = "#c8c093"
config.colors.cursor_border = "#c8c093"
config.colors.selection_fg = "#c8c093"
config.colors.selection_bg = "#2d4f67"
config.colors.scrollbar_thumb = "#16161d"
config.colors.split = "#16161d"
config.colors.ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" }
config.colors.brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" }
config.colors.indexed = { [16] = "#ffa066", [17] = "#ff5d62" }
--  change
-- config.window_background_opacity = 0.80
config.font = wezterm.font("Iosevka Nerd Font Mono", { weight = "Regular" })
config.prefer_egl = true
config.font_size = 18.0
config.window_decorations = "NONE"
config.default_prog = { "fish" }
config.hide_tab_bar_if_only_one_tab = true

-- config.window_background_image = "/home/diego/Imágenes/Wallpapers/DD19.jpg"
-- config.window_background_image_hsb = {
-- 	brightness = 0.015,
-- 	saturation = 0.8,
-- 	hue = 1,
-- }
config.window_background_image = "/home/diego/Imágenes/Wallpapers/DD20.png"
config.window_background_image_hsb = {
	brightness = 1.0,
}

return config
