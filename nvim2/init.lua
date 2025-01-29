-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- -- Ajusta el fondo del contexto de Treesitter con transparencia
-- vim.api.nvim_set_hl(0, "TreesitterContext", {
--   bg = "#000000", -- Elige un color de fondo que desees
--   blend = 50, -- Ajusta el nivel de transparencia (0 es opaco, 100 es completamente transparente)
-- })

-- vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
--   -- Aquí podrías filtrar el tipo de mensaje si solo quieres silenciar algunos
--   if result.type == 1 then -- Solo ignorar mensajes de error (tipo 1)
--     return
--   end
--   -- Muestra otros tipos de mensajes
--   vim.lsp.handlers["window/showMessage"](nil, result, ctx)
-- end
