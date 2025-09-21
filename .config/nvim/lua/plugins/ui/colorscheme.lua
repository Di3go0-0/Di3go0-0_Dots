return {
	---------------------------------------------------
	--- Transparent background for all colorschemes ---
	---------------------------------------------------

	{
		{
			"xiyaowong/transparent.nvim",
			config = function()
				require("transparent").setup({
					enable = true,
					extra_groups = { -- Grupos adicionales que deben volverse transparentes
						"Normal",
						"NormalNC",
						"Comment",
						"Constant",
						"Special",
						"Identifier",
						"Statement",
						"PreProc",
						"Type",
						"Underlined",
						"Todo",
						"String",
						"Function",
						"Conditional",
						"Repeat",
						"Operator",
						"Structure",
						"LineNr",
						"NonText",
						"SignColumn",
						"CursorLineNr",
						"EndOfBuffer",
					},
					exclude_groups = { "CursorLine", "InclineNormal", "InclineNormalNC" }, -- Excluir Incline para evitar conflictos
				})
				vim.cmd("TransparentEnable") -- Activa la transparencia
				vim.o.cursorline = true -- Activa el resaltado de la línea actual

				-- -- Opcional: Si aún no ves el resaltado de CursorLine, forzamos su color
				-- vim.api.nvim_create_autocmd("ColorScheme", {
				-- 	callback = function()
				-- 		vim.cmd("hi CursorLine guibg=#2c2c2c ctermbg=236") -- Ajusta según tu tema
				-- 	end,
				-- })
			end,
		},
	},

	----------------
	-- Catppuccin --
	----------------
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false,
	-- 	opts = {
	-- 		transparent_background = true,
	-- 		flavour = "mocha",
	-- 	},
	-- 	integrations = {
	-- 		cmp = true,
	-- 		gitsigns = true,
	-- 		nvimtree = true,
	-- 		treesitter = true,
	-- 		notify = false,
	-- 		mini = {
	-- 			enabled = true,
	-- 			indentscope_color = "",
	-- 		},
	-- 		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	-- 	},
	-- },

	--------------
	-- kanagawa --
	--------------

	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000,
		opts = {
			transparent = true,
			theme = "dragon",
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
		},
	},

	--------------
	-- Nerdtree --
	--------------

	-- {
	-- 	"preservim/nerdtree",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	name = "nerdtree",
	-- },

	----------------
	-- cyberdream --
	----------------

	-- {
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = function(_, opts)
	-- 		opts.transparent = true
	-- 		opts.italic_comments = true
	-- 		opts.borderless_telescope = false
	-- 	end,
	-- },

	--------------
	-- oldworld --
	--------------

	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			variant = "oled",
		},
	},

	------------------
	---- Gntleman ----
	------------------
	{
		"Gentleman-Programming/gentleman-kanagawa-blur",
		name = "gentleman-kanagawa-blur",
		priority = 1000,
	},
	{
		"Alan-TheGentleman/oldworld.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	--------------------------
	--  Main Configuration  --
	--------------------------

	{
		"LazyVim/LazyVim",
		opts = {
			-- change this line to change the color scheme
			colorscheme = "gentleman-kanagawa-blur",
			-- colorscheme = "catppuccin-macchiato",
			-- colorscheme = "cyberdream",
			-- colorscheme = "kanagawa-dragon",
			opts = {
				transparent_background = true,
			},
		},
	},
}
