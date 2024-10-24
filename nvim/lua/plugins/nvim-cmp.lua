-- Copilot With cmp
require("nvim-web-devicons").setup()

local icons = {
  buffer = "﬘", -- icono para buffer
  nvim_lsp = "ﲳ", -- icono para LSP
  luasnip = "", -- icono para snippets
  path = "ﱮ", -- icono para path
  copilot = "", -- icono para Copilot
}

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
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Añadir icono al kind
            vim_item.kind = string.format("%s %s", icons[entry.source.name] or "", vim_item.kind)

            -- Definir menú con iconos
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              path = "[Path]",
              copilot = "[Copilot]",
              -- copilot = "",
            })[entry.source.name] or ""

            return vim_item
          end,
          expandable_indicator = true, -- Indicación de elementos expandibles habilitada
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

    --Post config

    opts = function(_, opts)
      opts.completion.autocomplete = true
      opts.mapping["<CR>"] = nil
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

-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     opts = function(_, opts)
--       opts.completion.autocomplete = false
--       opts.mapping["<CR>"] = nil
--       opts.window = {
--         completion = {
--           border = {
--             { "󱐋", "WarningMsg" },
--             { "─", "Comment" },
--             { "╮", "Comment" },
--             { "│", "Comment" },
--             { "╯", "Comment" },
--             { "─", "Comment" },
--             { "╰", "Comment" },
--             { "│", "Comment" },
--           },
--           scrollbar = false,
--           winblend = 0,
--         },
--         documentation = {
--           border = {
--             { "󰙎", "DiagnosticHint" },
--             { "─", "Comment" },
--             { "╮", "Comment" },
--             { "│", "Comment" },
--             { "╯", "Comment" },
--             { "─", "Comment" },
--             { "╰", "Comment" },
--             { "│", "Comment" },
--           },
--           scrollbar = false,
--           winblend = 0,
--         },
--       }
--     end,
--   },
-- }
