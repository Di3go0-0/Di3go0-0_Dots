local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function set_keymaps()
	keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file and stay in insert mode" })
	keymap.set("v", "<leader>sc", ":SSSelected<CR>", { desc = "Capture selected code" })
	-- Open oil
	keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

	-- keymap.set("n", "<leader>an", "<cmd>AvanteNewChat<cr>", { desc = "Avante: New Chat" })
	keymap.set("n", "te", ":tabedit", opts) -- New tab
	keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Next tab
	keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Previous tab
	keymap.set("n", "<leader><tab>d", ":tabclose<Return>", opts) -- Close current tab

	-- Copy current buffer full path to clipboard
	keymap.set("n", "<leader>fp", function()
		local path = vim.fn.expand("%:p")
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Copy file path to clipboard" })
end

set_keymaps()
