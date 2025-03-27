return {
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false, -- Recommended
	-- 	-- ft = "markdown" -- If you decide to lazy-load anyway
	--
	-- 	dependencies = {
	-- 		-- You will not need this if you installed the
	-- 		-- parsers manually
	-- 		-- Or if the parsers are in your $RUNTIMEPATH
	-- 		"nvim-treesitter/nvim-treesitter",
	--
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = {
				enabled = true,
				sign = true,
				style = "full",
				icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
				left_pad = 1,
			},
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
				right_pad = 1,
				highlight = "render-markdownBullet",
			},
		},
	},
}
