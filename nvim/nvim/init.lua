-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.cursorline = false -- Desactiva el resaltado de la línea del cursor
vim.cmd("highlight CursorLineNr guifg=#FFD700") -- Cambia el color del número de línea del cursor (ajusta el color según prefieras)
vim.opt.syntax = "on" -- Activa el resaltado de sintaxis
vim.cmd("highlight Identifier guifg=#00FF00") -- Resal qta

-- Resaltar identificadores bajo el cursor con un color específico
vim.cmd("highlight LspReferenceText guibg=#3E3E3E guifg=#FFFFFF") --Resaltado de texto cuando se selecciona una referencia
vim.cmd("highlight LspReferenceRead guibg=#11619C guifg=#FFFFFF") --Reasaltado de lectura cuando se selecciona una referencia
vim.cmd("highlight LspReferenceWrite guibg=#3E3E3E guifg=#FFFFFF") -- Resaltar escritura cuando se selecciona una referencia

-- Configurar LSP para resaltar referencias bajo el cursor
vim.cmd("autocmd CursorHold * lua vim.lsp.buf.document_highlight()")
vim.cmd("autocmd CursorMoved * lua vim.lsp.buf.clear_references()")
