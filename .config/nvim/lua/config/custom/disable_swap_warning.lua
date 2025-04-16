-- Configuración para manejar archivos swap y sus advertencias

-- Método 1: Deshabilitar completamente los archivos swap
-- Descomenta si quieres esta opción
-- vim.opt.swapfile = false

-- Método 2: Redirigir los archivos swap a un directorio específico (asegúrate de que exista)
-- vim.opt.directory = vim.fn.expand("~/.cache/nvim/swap//")

-- Método 3: Silenciar específicamente las advertencias de swap
local notify_original = vim.notify
vim.notify = function(msg, level, opts)
  -- Ignora específicamente mensajes sobre archivos swap
  if msg and (msg:match("Ignoring swapfile") or msg:match("W325")) then
    return
  end
  
  -- Deja pasar cualquier otro tipo de notificación
  notify_original(msg, level, opts)
end

-- Opcional: Configuración adicional para mejorar la experiencia con archivos
-- vim.opt.updatetime = 300 -- Guarda el archivo swap después de 300ms de inactividad (default es 4000ms)
-- vim.opt.writebackup = false -- No crear archivo de respaldo antes de sobrescribir
-- vim.opt.backup = false -- No mantener archivos de respaldo después de sobrescribir
