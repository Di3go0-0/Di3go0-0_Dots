return {
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-completion" },

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_save_location = "~/.local/share/db_ui"

			vim.keymap.set("n", "<leader>rs", "vip<Plug>(DBUI_ExecuteQuery)", { desc = "Run current select" })

			local function navigate_db_results(direction)
				-- 1. Buscar todos los buffers de resultados
				local r_buffers = {}
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					-- Verificamos por filetype o por nombre de archivo .dbout
					if vim.bo[bufnr].filetype == "dbout" or vim.api.nvim_buf_get_name(bufnr):match("%.dbout$") then
						table.insert(r_buffers, bufnr)
					end
				end

				if #r_buffers == 0 then
					print("No se encontraron buffers de resultados (.dbout)")
					return
				end

				-- 2. Identificar la ventana de resultados (la de abajo)
				local res_win = nil
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == "dbout" or vim.api.nvim_buf_get_name(buf):match("%.dbout$") then
						res_win = win
						break
					end
				end

				-- 3. Si la ventana no está abierta, la abrimos en un split abajo
				if not res_win then
					vim.cmd("botright sbuf " .. r_buffers[#r_buffers])
					return
				end

				-- 4. Lógica de navegación
				local current_res_buf = vim.api.nvim_win_get_buf(res_win)
				local idx = 1
				for i, bufnr in ipairs(r_buffers) do
					if bufnr == current_res_buf then
						idx = i
						break
					end
				end

				if direction == "next" then
					idx = idx % #r_buffers + 1
				else
					idx = (idx - 2 + #r_buffers) % #r_buffers + 1
				end

				-- 5. Aplicar el cambio
				vim.api.nvim_win_set_buf(res_win, r_buffers[idx])

				-- Opcional: Centrar el resultado
				vim.api.nvim_win_call(res_win, function()
					vim.cmd("normal! gg")
				end)
			end

			-- Mapeos
			vim.keymap.set("n", "<leader>rn", function()
				navigate_db_results("next")
			end, { desc = "Siguiente resultado SQL" })

			vim.keymap.set("n", "<leader>rp", function()
				navigate_db_results("prev")
			end, { desc = "Anterior resultado SQL" })
		end,
	},
}
