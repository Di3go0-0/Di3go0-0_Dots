return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- Añadimos sql a la lista de treesitter principal
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "sql" })
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = function()
			local tsc = require("treesitter-context")
			-- Integración con Snacks para el toggle
			Snacks.toggle({
				name = "Treesitter Context",
				get = tsc.enabled,
				set = function(state)
					if state then
						tsc.enable()
					else
						tsc.disable()
					end
				end,
			}):map("<leader>ut")

			return { mode = "cursor", max_lines = 3 }
		end,
	},
}
