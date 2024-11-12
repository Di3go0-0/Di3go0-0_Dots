-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- -- Desactiva el resaltado de la línea completa
vim.opt.cursorline = true
--
-- -- Resalta solo el número de la línea actual (ajusta el color según prefieras)
-- vim.cmd("highlight CursorLineNr guifg=#f0ea14")
-- -- eliminar cualquierr resaltado de la linea completa
-- vim.cmd("highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")

-- -- Activa el resaltado de sintaxis
-- vim.opt.syntax = "on"
--
-- -- -- Resaltar identificadores con un color específico
-- vim.cmd("highlight Identifier guifg=#00FF00")
-- --
-- -- -- Simula un efecto suave sin transparencia
-- -- -- vim.cmd("highlight Visual guibg=#000000 guifg=NONE")
-- --
-- -- -- Resaltar referencias de LSP bajo el cursor
-- vim.cmd("highlight LspReferenceText guibg=#11619C guifg=#FFFFFF")
-- vim.cmd("highlight LspReferenceRead guibg=#11619C guifg=#FFFFFF")
-- vim.cmd("highlight LspReferenceWrite guibg=#3E3E3E guifg=#FFFFFF")
-- --
-- -- Configurar LSP para resaltar referencias bajo el cursor
-- -- vim.cmd("autocmd CursorHold * lua vim.lsp.buf.document_highlight()")
-- -- vim.cmd("autocmd CursorMoved * lua vim.lsp.buf.clear_references()")

----------------------------------------------

-- Ajusta el fondo del contexto de Treesitter con transparencia
-- vim.api.nvim_set_hl(0, "TreesitterContext", {
--   bg = "#000000", -- Elige un color de fondo que desees
--   blend = 50, -- Ajusta el nivel de transparencia (0 es opaco, 100 es completamente transparente)
-- })

--
--
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
  -- Aquí podrías filtrar el tipo de mensaje si solo quieres silenciar algunos
  if result.type == 1 then -- Solo ignorar mensajes de error (tipo 1)
    return
  end
  -- Muestra otros tipos de mensajes
  vim.lsp.handlers["window/showMessage"](nil, result, ctx)
end
