return {
	{
		"Di3go0-0/restui.nvim",
		lazy = true,
		cmd = { "Restui" },
		keys = {
			{ "<leader>rr", "<cmd>Restui<cr>", desc = "Restui HTTP Client" },
		},
		config = function()
			require("restui").setup({
				float_opts = {
					width = 0.95,
					height = 0.95,
					border = "rounded",
				},
			})
		end,
	},
}
