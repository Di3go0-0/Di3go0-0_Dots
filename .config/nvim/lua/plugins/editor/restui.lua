return {
	{
		"Di3go0-0/restui.nvim",
		branch = "main",
		lazy = true,
		cmd = { "Restui" },
		keys = {
			{ "<leader>rr", "<cmd>Restui<cr>", desc = "Restui HTTP Client" },
		},
		config = function()
			require(".config.nvim.lua.plugins.databases.dbtui").setup({
				float_opts = {
					width = 0.95,
					height = 0.95,
					border = "rounded",
				},
			})
		end,
	},
}
