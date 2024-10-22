-- Copilot With cmp

return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip", -- Soporte para snippets
      {
        "zbirenbaum/copilot-cmp",
        dependencies = {
          "zbirenbaum/copilot.lua",
        },
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
          require("copilot_cmp").setup({
            method = "getCompletionsCycling",
          })
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources({
          { name = "copilot", group_index = 1, priority = 100 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" }, -- Campos a mostrar
          format = function(entry, vim_item)
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              path = "[Path]",
              copilot = "[Copilot]",
            })[entry.source.name] or ""
            return vim_item
          end,
          -- Cambiar expandable_indicator a un booleano
          -- Puedes usar `true` para habilitar la indicación de elementos expandibles
          expandable_indicator = true,
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },
}
