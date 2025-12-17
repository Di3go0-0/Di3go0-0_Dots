local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function set_keymaps()
	keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file and stay in insert mode" })
	keymap.set("v", "<leader>sc", ":SSSelected<CR>", { desc = "Capture selected code" })
	-- Open oil
	keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

	keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })

	-- keymap.set("n", "<leader>an", "<cmd>AvanteNewChat<cr>", { desc = "Avante: New Chat" })
	keymap.set("n", "te", ":tabedit", opts) -- New tab
	keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Next tab
	keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Previous tab
	keymap.set("n", "<leader><tab>d", ":tabclose<Return>", opts) -- Close current tab
end

set_keymaps()
