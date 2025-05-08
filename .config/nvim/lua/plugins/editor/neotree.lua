return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		{ "DaikyXendo/nvim-material-icon" },
	},
	cmd = "Neotree",
	opts = {
		source_selector = {
			winbar = true,
			content_layout = "center",
			sources = {
				{ source = "filesystem", display_name = " File" },
				{ source = "buffers", display_name = "󰈙 Buff" },
				{ source = "git_status", display_name = "󰊢 Git" },
			},
		},
		window = {
			position = "right",
			mappings = {
				["Y"] = "none",
				["H"] = "prev_source",
				["L"] = "next_source",
			},
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_by_name = {
					".git",
					".DS_Store",
				},
				always_show = {
					".env",
					"*.png",
					".gitignore",
					"dist",
					"venv",
				},
			},
		},
		default_component_configs = {
			git_status = {
				symbols = {
					-- Change type
					added = "✚", -- NOTE: you can set any of these to an empty string to not show them
					deleted = "✖",
					modified = "",
					renamed = "",
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
				align = "right",
			},
		},
	},
}
