return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      transparent_background = true,
      flavour = "mocha",
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    opts = {
      transparent = true,
      theme = "dragon",
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },

  {
    "xiyaowong/transparent.nvim",
  },

  {
    "preservim/nerdtree",
    lazy = false,
    priority = 1000,
    name = "nerdtree",
  },
  {
    "sho-87/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    name = "kanagawa-paper",
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    config = function()
      require("everforest").setup({
        background = "hard",
        italics = true, -- Opción corregida
        transparent_background_level = 1,
        diagnostic_text_highlight = true,
        diagnostic_virtual_text = "coloured",
        disable_italic_comments = false,
        sign_column_background = "none", -- Campo requerido
        ui_contrast = "high", -- Campo requerido
        dim_inactive_windows = true, -- Campo requerido
        diagnostic_line_highlight = true, -- Campo requerido
        spell_foreground = false, -- Campo requerido
        show_eob = false, -- Campo requerido
        float_style = "dim", -- Campo requerido
        inlay_hints_background = "none", -- Campo requerido (puedes cambiar "none" a otro color si prefieres)
        on_highlights = function(hl, c)
          -- Puedes añadir configuraciones adicionales de resaltado aquí
        end,
        colours_override = function(palette)
          palette.bg0 = "#1A1A22"
        end,
      })
    end,
  },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      opts.transparent = true
      opts.italic_comments = true
      opts.borderless_telescope = false
    end,
  },

  {
    "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- change this line to change the color scheme
      colorscheme = "catppuccin-mocha",
      -- colorscheme = "cyberdream",
      -- colorscheme = "kanagawa-dragon",
      opts = {
        transparent_background = true,
      },
    },
  },
}
