return {
	------- For img -------
	------- Install -------
	-- yay -S ueberzugpp --
	-----------------------

	-- {
	-- 	"zbirenbaum/copilot-cmp", -- Esta es la dependencia necesaria
	-- 	after = "copilot.nvim", -- Asegúrate de que se cargue después de Copilot
	-- },

	-------------------
	--- Comentarios ---
	-------------------

	{ "numToStr/Comment.nvim" },

	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	tag = "0.1.8",
	-- 	-- or                              , branch = '0.1.x',
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },

	----------------------------------------------------------
	-- Plugin to provide network functionalities for Neovim --
	----------------------------------------------------------

	{ "neovim/nvim.net" },

	-------------------
	-- Multi Cursors --
	-------------------

	{
		"mg979/vim-visual-multi",
	},

	-- {
	-- 	-- Plugin: vim-multiple-cursors
	-- 	-- URL: https://github.com/terryma/vim-multiple-cursors
	-- 	-- Description: A Vim plugin that allows multiple cursors for simultaneous editing.
	-- 	"terryma/vim-multiple-cursors",
	-- 	require("plugins.coding.multi-line"),
	-- },

	------------
	-- Rename --
	------------

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	--------------------------
	-- Personalized notifys --
	--------------------------

	{
		"rcarriga/nvim-notify",
	},

	------------------
	--- Key shorts ---
	------------------

	{
		"andymass/vim-matchup",
		event = { "BufReadPost" },
		init = function()
			vim.o.matchpairs = "(:),{:},[:]"
		end,
		config = function()
			-- ...
		end,
	}, -- Lua

	----------------
	-- Screenshot --
	----------------

	{
		-- we neet
		-- sss_code => brew install SergioRibera/homebrew-tap/sss_code
		-- and to see the themes => sss_code -L

		"SergioRibera/codeshot.nvim",
		config = function()
			require("codeshot").setup({
				theme = "Coldark-Dark",
				-- copy = "xclip -selection clipboard -target image/png",
				-- padding_x = 50,
				-- padding_y = 50,
				author = "Di3go0-0",
				use_current_theme = false,
			})
		end,
	},

	-------------
	-- Imports --
	-------------

	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension("import")
		end,
	},
	-- { "rafamadriz/friendly-snippets" },

	--------------------------------
	-- See Params of the function --
	--------------------------------

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},

	----------------------------------------------
	-- Plugin to show the color of the hex code --
	----------------------------------------------

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*", -- Activa colorizer para todos los archivos
				css = { rgb_fn = true }, -- Soporte especial para archivos CSS
				html = { names = false }, -- Desactiva el soporte para nombres de colores en archivos HTML
				default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					RRGGBBAA = true, -- #RRGGBBAA hex codes con alpha
					rgb_fn = true, -- CSS rgb() y rgba()
					hsl_fn = true, -- CSS hsl() y hsla()
					css = true, -- Habilita todos los formatos CSS
					css_fn = true, -- Habilita funciones CSS
				},
			})
		end,
	},

	------------------
	--- Nvim Utils ---
	------------------

	{
		"nvim-lua/plenary.nvim",
	},

	------------------
	--- Rainbow CSV ---
	------------------

	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
}
