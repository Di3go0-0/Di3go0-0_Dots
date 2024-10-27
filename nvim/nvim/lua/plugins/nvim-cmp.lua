return {
  {
    "hrsh7th/nvim-cmp",
    dependences = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-copilot",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged }, -- Activa autocompletado al escribir
      }
      opts.mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
      }
      -- opts.sources = cmp.config.sources({
      --   { name = "copilot", priority = 1000 }, -- Prioridad alta para Copilot
      --   { name = "nvim_lsp", priority = 750 },
      --   { name = "buffer", priority = 500 },
      --   { name = "path", priority = 250 },
      -- })
      opts.window = {
        completion = {
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
        },
        documentation = {
          border = {
            { "󰙎", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
        },
      }
    end,
  },
}
