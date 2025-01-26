return {
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "hrsh7th/cmp-nvim-lsp" },
  --   },
  -- },
  { "numToStr/Comment.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Plugin to provide network functionalities for Neovim
  { "neovim/nvim.net" },
  {
    "mg979/vim-visual-multi",
    -- v,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  {
    "rcarriga/nvim-notify",
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    init = function()
      vim.o.matchpairs = "(:),{:},[:]"
    end,
    config = function()
      -- ...
    end,
  }, -- Lua
  -- Plugin to take a screenshot of the code
  {
    -- we neet
    -- sss_code => brew install SergioRibera/homebrew-tap/sss_code
    -- and to see the themes => sss_code -L

    "SergioRibera/codeshot.nvim",
    config = function()
      require("codeshot").setup({
        theme = "Visual Studio Dark+",
        -- copy = "xclip -selection clipboard -target image/png",
        -- padding_x = 50,
        -- padding_y = 50,
        author = "Di3go0-0",
        use_current_theme = false,
      })
    end,
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },
  { "rafamadriz/friendly-snippets" },
  -- Plugin to show the signature of the function
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  -- Plugin to show the color of the hex code
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*", -- Activa colorizer para todos los archivos
        css = { rgb_fn = true }, -- Soporte especial para archivos CSS
        html = { names = false }, -- Desactiva el soporte para nombres de colores en archivos HTML
      })
    end,
  },
}
