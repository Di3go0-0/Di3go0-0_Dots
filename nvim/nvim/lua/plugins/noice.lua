return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("noice").setup({
      lsp = {
        hover = {
          enabled = false, -- Deshabilitar hover de Noice
        },
      },
      cmdline = {
        enabled = true, -- Habilitar la funcionalidad del cmdline
        -- No se especifica el view, para que use la configuración por defecto de LazyVim
      },
    })
  end,
}
