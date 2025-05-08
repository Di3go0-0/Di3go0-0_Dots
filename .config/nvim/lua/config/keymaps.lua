local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function set_keymaps()
	keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)
	keymap.set("v", "<leader>sc", ":SSSelected<CR>", { desc = "Capture selected code" })
	-- Open oil
	keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

	keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })
end

set_keymaps()
