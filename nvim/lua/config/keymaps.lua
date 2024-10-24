-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local Util = require("lazyvim.util")

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
  safe_del("n", "<leader>wh")
  safe_del("n", "<leader>wl")

  -- Añadir nuevas keymaps
  keymap.set("n", "<C-j>", "<leader>wh", opts)
  keymap.set("n", "<C-k>", "<leader>wl", opts)
end

-- Llamar a la función para establecer las keymaps
set_keymaps()
