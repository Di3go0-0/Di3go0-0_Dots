local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function set_keymaps()
  keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)
  keymap.set("v", "<leader>sc", ":SSSelected<CR>", { desc = "Capture selected code" })
  -- Open oil
  keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

----- OBSIDIAN -----
vim.keymap.set(
  "n",
  "<leader>oc",
  "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
  { desc = "Obsidian Check Checkbox" }
)
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

-- Llamar a la función para establecer las keymaps
set_keymaps()
