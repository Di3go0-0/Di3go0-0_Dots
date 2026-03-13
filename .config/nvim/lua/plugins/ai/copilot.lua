return {

	"zbirenbaum/copilot.lua",
	optional = true,
	opts = function()
		require("copilot.api").status = require("copilot.status")
		require("copilot.api").filetypes = {
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
		}
		vim.keymap.set("n", "<leader>at", ":Copilot toggle<CR>", { desc = "Toggle Copilot" })
		vim.keymap.set("n", "<leader>aa", ":CopilotChat Accept<CR>", { desc = "Copilot Accept" })
		vim.keymap.set("n", "<leader>an", ":CopilotChat<CR>", { desc = "Copilot Chat" })
	end,
}
