-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.cursorline = false -- Desactiva el resaltado de la línea del cursor
vim.cmd("highlight CursorLineNr guifg=#FFD700") -- Cambia el color del número de línea del cursor (ajusta el color según prefieras)
vim.opt.syntax = "on" -- Activa el resaltado de sintaxis
vim.cmd("highlight Identifier guifg=#00FF00") -- Resaltar identificadores (variables, funciones, etc.) en verde
