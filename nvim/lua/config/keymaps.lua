-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function safe_del(mode, lhs)
  local status, _ = pcall(function()
    keymap.del(mode, lhs)
  end)
  if not status then
    print("No se pudo eliminar el mapeo: " .. lhs)
  end
end

local function set_keymaps()
  -- Eliminar keymaps existentes de forma segura
  -- safe_del("n", "<C-h>")
  -- safe_del("n", "<C-l>")
  -- safe_del("n", "<C-s>")
  -- --
  -- --  Añadir nuevas keymaps
  -- keymap.set("n", "<C-h>", "<C-w>h", opts) -- Left
  -- keymap.set("n", "<C-k>", "<C-w>k", opts) -- Up
  -- keymap.set("n", "<C-j>", "<C-w>j", opts) -- Down
  -- keymap.set("n", "<C-l>", "<C-w>l", opts) -- Right

  -- Configurar atajo de teclado para guardar un archivo con Ctrl + k en modo normal e insert
  keymap.set("n", "<C-s>", ":w<CR>", opts)
  keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)
  keymap.set("v", "<leader>sc", ":SSSelected<CR>", { desc = "Capture selected code" })
  -- Open oil
  keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

-- Llamar a la función para establecer las keymaps
set_keymaps()
