return {
  -- Plugin para nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configurar el servidor de lenguaje para HTML
      require("lspconfig").html.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Puedes agregar más configuraciones de LSP aquí si lo deseas
    end,
  },
}
