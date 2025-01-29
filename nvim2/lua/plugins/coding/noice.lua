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
    })
  end,
}
