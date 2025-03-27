local wezterm = require("wezterm")

local act = wezterm.action

local config = wezterm.config_builder()

-- Cambiado 'front_end' a 'OpenGL' (u otro backend gráfico válido)
config.front_end = "OpenGL"
config.max_fps = 144
-- Corregido 'defautl_cursor_style' a 'default_cursor_style'
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color"

config.font = wezterm.font("Iosevka Nerd Font Mono", { weight = "Regular" })

config.cell_width = 0.9

config.window_background_opacity = 0.9
config.prefer_egl = true
config.font_size = 18.0
config.warn_about_missing_glyphs = false

config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == "Zenburn" then
		overrides.color_scheme = "Cloud (terminal.sexy)"
	else
		overrides.color_scheme = "Zenburn"
	end
	window:set_config_overrides(overrides)
end)

-- keymaps
config.keys = {
	{
		key = "E",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.EmitEvent("toggle-colorscheme"),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "U",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "I",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "O",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	{
		key = "O",
		mods = "CTRL|ALT",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.9
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

-- For example, changing the color scheme:
config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	background = "#0c0b0f", -- dark purple
	cursor_border = "#bea3c7",
	cursor_bg = "#bea3c7",

	tab_bar = {
		background = "#0c0b0f",
		active_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#bea3c7",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			bg_color = "#0c0b0f",
			fg_color = "white",
		},
	},
}

config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "#0c0b0f",
}

-- config.window_decorations = "NONE | RESIZE"
config.window_decorations = "NONE"
config.default_prog = { "fish" }
config.window_background_opacity = 1
config.initial_rows = 80

config.window_background_image = "/home/diego/Imágenes/Wallpapers/DD12.jpg"
config.window_background_image_hsb = {
	brightness = 0.08,
	saturation = 0.8,
	hue = 1,
}
config.text_background_opacity = 1

return config
