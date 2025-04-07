return {

	---------------------
	--- Custom Column ---
	---------------------

	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			char = { "┆" },
			virtcolumn = "80",
			highlight = { "NonText" },
		},
	},

	---------------------------
	--- Progresing messages ---
	---------------------------

	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
					border = "rounded",
				},
			},
		},
	},

	-------------------------
	--- Hide Files Buffer ---
	-------------------------

	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	--------------------
	--- Dialog boxes ---
	--------------------

	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	--------------------
	--- Status Line ----
	--------------------

	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = "#392671", guifg = "#ffffff" }, -- Asegurar que no sea transparente
						InclineNormalNC = { guibg = "#10003E", guifg = "#777777" },
					},
				},
				window = {
					margin = { vertical = 1, horizontal = 1 },
					padding = 2,
					---- To show the name down in the page ----
					-- placement = {
					-- 	horizontal = "right",
					-- 	vertical = "bottom",
					-- },
				},
				render = function(props)
					-- Obtener la posición del cursor solo si es el buffer activo
					if props.focused then
						local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
						local total_lines = vim.api.nvim_buf_line_count(0)

						-- cursor_line == total_lines => ultima linea
						-- Si el cursor está en la primera no renderizar
						if cursor_line == 1 then
							return nil
						end
					end

					-- Mostrar el nombre si no está el cursor en la línea "peligrosa"
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[*]" .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon(filename, nil, { default = true })
					if not icon then
						icon = ""
					end

					return {
						{ icon, guifg = color },
						{ "   " },
						{ filename },
					}
				end,
			})
		end,
	},
	-----------------
	--- dashboard ---
	-----------------

	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	opts = function(_, opts)
	-- 		local logo = [[
	--   ]]
	-- 		logo = string.rep("\n", 8) .. logo .. "\n\n"
	-- 		opts.header = vim.split(logo, "\n")
	-- 	end,
	-- },

	{
		"folke/snacks.nvim",
		opts = {
			image = { enabled = true },
			dashboard = {
				sections = {
					{ section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
				preset = {
					header = [[
	 ⠀⠀⠀⠀⠀⠀⠀⣰⣾⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠀⠀⠀⠀⠀⣠⣿⣿⣟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠀⠀⠀⠀⣴⣿⡿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠀⠀⣠⠾⠋⠁⠀⣿⣿⣿⣥⣶⣤⣤⣀⠀⣀⠀⢀⣀⣀⣀⣠⣤⣤⣤⣶⣦⣄⡀
	 ⠀⠀⠀⢀⣠⣤⣶⣿⣿⣿⣿⠿⠿⠟⠋⢸⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⠷
	 ⢴⣶⣿⣿⣿⡿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⣿⣿⣿⠉⠁⠀⠀⠀⢰⣿⣿⣿⠏⠀
	 ⠀⠉⠙⠋⠀⣰⣿⣿⣿⣿⡿⢿⣿⣷⡄⠀⢸⣿⣿⡇⠀⠀⠀⢀⣾⣿⣿⡿⠀⠀
	 ⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡇⠀⠈⠉⠁⠀⢀⣿⣿⣷⣴⣶⣶⣾⣿⣿⣿⠁⠀⠀
	 ⠀⠀⠀⣰⣿⠿⠃⢸⣿⣿⡇⠀⠀⠀⠀⠀⠈⠻⢿⣿⡿⠿⠟⠿⠛⠛⠁⠀⠀⠀
	 ⠀⣀⠼⠛⠁⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠈⠁⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
	 ⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠇⠀
	 ]],
	         -- stylua: ignore
	         ---@type snacks.dashboard.Item[]
	         keys = {
	           { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
	           { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
	           { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
	           { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
	           { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
	           { icon = " ", key = "s", desc = "Restore Session", section = "session" },
	           { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
	           { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
	           { icon = " ", key = "q", desc = "Quit", action = ":qa" },
	         },
				},
			},
		},
	},
}

-- Gentleman Programming
--                     ░░░░░░      ░░░░░░
--                   ░░░░░░░░░░  ░░░░░░░░░░
--                 ░░░░░░░░░░░░░░░░░░░░░░░░░░
--               ░░░░░░░░░░▒▒▒▒░░▒▒▒▒░░░░░░░░░░
--             ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
-- ▒▒        ░░░░░░▒▒▒▒▒▒▒▒▒▒██▒▒██▒▒▒▒▒▒▒▒▒▒░░░░░░        ▒▒
--  ▒▒░░    ░░░░░░░░▒▒▒▒▒▒▒▒▒▒████▒▒████▒▒▒▒▒▒▒▒▒▒░░░░░░░░    ░░▒▒
--  ▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████▒▒██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒
--  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██████▓▓██▒▒██████▒▒▓▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
-- ████▒▒▒▒▒▒████▒▒▒▒██████████  ██████████▒▒▒▒████▒▒▒▒▒▒▒▒██
--   ████████████████████████      ████████████████████████
--     ██████████████████              ██████████████████
--         ██████████                      ██████████
--

-- Samuray
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⣀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠉⠁⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠦⠂⠀⠀⠀⠀⠀⠀⠀⢹⣿⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠚⢳⣦⣄⡀⠀⠀⠀⠀⢸⣿⣤⡿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠒⠉⠀⠀⠀⠀⠻⣼⠹⣗⢦⣄⣰⣿⣿⣿⣥⣶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠂⣤⠴⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠹⣗⠮⣭⡟⢱⣿⣿⣿⡛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠚⠁⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⣆⠀⠹⣿⡿⢀⣾⣿⣿⣿⣛⡷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣏⡁⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠘⠁⠀⣿⣄⡴⠋⢀⣼⣿⢤⣬⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠄
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠓⠶⢤⣄⣀⣘⠃⠀⠀⠀⢺⠁⠀⡾⠋⠀⣠⣿⣿⣿⣿⣿⣿⡿⠃⠀⣴⣶⣶⣷⠶⠶⠀⠀⠀⠀⠀⠀⢀⢢⣔⣱⣮⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠉⢿⣿⣿⣿⣶⣶⠏⠀⢀⣾⣿⣿⣿⣿⣿⣿⣇⢀⣀⣰⣿⣿⡏⠉⠀⠀⠀⠀⠀⠀⢀⠸⣎⣷⣿⣿⣷⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣶⣿⣿⣿⣾⣿⢿⡿⠛⠁⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⡟⠛⠛⠁⠀⠀⣀⣴⣣⣿⣿⣿⣿⣿⣿⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⡿⠛⠉⡴⠋⠀⢀⡴⣻⣽⣿⣿⣿⣿⣿⣿⡛⠟⠿⢻⣿⣿⡛⠁⣽⡄⠀⣀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⡟⠀⠀⠈⠀⢀⡴⢯⣳⣿⡿⠷⣿⣿⣿⣿⣬⣟⣛⠛⡋⢸⣿⣿⣷⣞⣷⣾⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡟⠀⠀⣀⣀⡴⣏⣼⣿⣿⣿⣦⣤⣸⣿⣿⣿⣿⣿⠮⣍⣉⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⡇⣠⣟⣯⣵⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⣤⡴⣖⡷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⠀⠀⠀⠀⠀⢀⣀⡤⣴⡶⣿⣿⣽⣷⣿⡿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣠⣤⣤⣤⣼⣿⣻⣿⣿⣿⣿⡿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣇⠘⢧⡘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⣿⣾⣿⣿⣻⣿⣿⣯⣿⣟⣿⣿⡿⣟⣯⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⢚⣇⠈⠱⠄⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⣳⢯⣷⢿⣟⣿⣿⣽⣿⢿⣿⣻⣿⣿⣿⢿⣻⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣭⠾⣆⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
-- ⣿⡽⣟⣯⣿⣞⡿⣞⣯⢿⣻⡽⣟⣷⢿⡾⣿⣟⣯⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣦⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
--
-- Source : https://emojicombos.com/
--
-- Obito
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⢀⣠⣴⠾⠟⠛⠛⠛⠛⠛⠷⣦⣄⡀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⢀⣴⠟⣉⣠⣤⣤⣤⣤⣤⣄⡀⠀⠀⠉⠻⣦⡀⠀⠀⠀
-- ⠀⠀⣰⣿⣵⣿⣿⡿⠛⠉⠀⠀⠀⠀⠉⠑⠄⡀⠀⠈⢻⣆⠀⠀
-- ⠀⢰⡟⠹⣿⣿⣿⣷⣶⣦⣄⡀⢀⣠⣴⣶⣿⣿⣿⣿⣿⣿⠀⠀
-- ⠀⣿⠁⠀⢸⢿⣿⣿⣿⣿⠟⠉⠉⠻⣿⣿⣿⣿⡿⣿⣿⡏⣿⠀
-- ⠀⣿⠀⠀⢸⠀⠙⠻⣿⡇⠀⠀⠀⠀⢸⣿⠟⠉⠀⣿⣿⠀⣿⠇
-- ⠀⣿⡀⠀⢸⡄⠀⠀⠈⢻⣦⣀⣀⣤⣿⠁⠀⠀⢀⣿⠃⢀⣿⠀
-- ⠀⠸⣧⠀⠀⢿⡄⠀⠀⠸⣿⣿⣿⣿⡇⠀⠀⢀⡾⠃⠀⣼⠏⠀
-- ⠀⠀⠹⣷⡀⠈⢿⣶⣄⡀⢿⣿⣿⣿⢃⡠⠔⠋⠀⢀⣼⠏⠀⠀
-- ⠀⠀⠀⠈⠻⣦⣀⠙⢿⣿⣿⣿⣿⡏⠁⠀⠀⣀⣴⠟⠁⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠈⠙⠻⠶⣯⣿⣿⣿⣤⣴⠶⠟⠋⠁⠀⠀⠀⠀⠀
-- Harmony Japanese
--
-- ⠀⠀⠀⠀⠀⠀⠀⣰⣾⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⣠⣿⣿⣟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⣴⣿⡿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⣠⠾⠋⠁⠀⣿⣿⣿⣥⣶⣤⣤⣀⠀⣀⠀⢀⣀⣀⣀⣠⣤⣤⣤⣶⣦⣄⡀
-- ⠀⠀⠀⢀⣠⣤⣶⣿⣿⣿⣿⠿⠿⠟⠋⢸⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⠷
-- ⢴⣶⣿⣿⣿⡿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⣿⣿⣿⠉⠁⠀⠀⠀⢰⣿⣿⣿⠏⠀
-- ⠀⠉⠙⠋⠀⣰⣿⣿⣿⣿⡿⢿⣿⣷⡄⠀⢸⣿⣿⡇⠀⠀⠀⢀⣾⣿⣿⡿⠀⠀
-- ⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡇⠀⠈⠉⠁⠀⢀⣿⣿⣷⣴⣶⣶⣾⣿⣿⣿⠁⠀⠀
-- ⠀⠀⠀⣰⣿⠿⠃⢸⣿⣿⡇⠀⠀⠀⠀⠀⠈⠻⢿⣿⡿⠿⠟⠿⠛⠛⠁⠀⠀⠀
-- ⠀⣀⠼⠛⠁⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠈⠁⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠇⠀⠀⠀⠀
