-- ~/.config/nvim/lua/plugins/LuaSnip.lua

return {
  -- Plugin para LuaSnip
  {
    "L3MON4D3/LuaSnip",
    version = "1.*", -- Utiliza la versión estable de LuaSnip
    dependencies = {
      "rafamadriz/friendly-snippets", -- Snippets adicionales
    },
    config = function()
      -- Cargar snippets desde friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Puedes cargar tus propios snippets aquí si los tienes
      -- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

      -- Mapeos de teclas para expandir y saltar en snippets
      vim.api.nvim_set_keymap(
        "i",
        "<Tab>",
        'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"',
        { silent = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<S-Tab>", '<cmd>lua require("luasnip").jump(-1)<CR>', { silent = true })
      vim.api.nvim_set_keymap("s", "<Tab>", '<cmd>lua require("luasnip").jump(1)<CR>', { silent = true })
      vim.api.nvim_set_keymap("s", "<S-Tab>", '<cmd>lua require("luasnip").jump(-1)<CR>', { silent = true })

      -- Otras configuraciones opcionales para LuaSnip
    end,
  },

  -- Plugin para nvim-cmp y su integración con LuaSnip
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip", -- Asegura que LuaSnip esté cargado
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Usa LuaSnip para expandir snippets
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" }, -- Compleciones del LSP
          { name = "luasnip" }, -- Compleciones de snippets
          -- Otros sources que puedas querer
        },
      })
    end,
  },

  -- Plugin opcional para el manejo de iconos en el autocompletado
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol_text", -- Mostrar íconos con texto
        preset = "default", -- Configuración por defecto
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })
    end,
  },
}
