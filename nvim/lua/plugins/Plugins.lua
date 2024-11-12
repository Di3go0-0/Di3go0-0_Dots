return {
  -- 'nvim-treesitter/nvim-treesitter',
  -- 'nvim-treesitter/playground',
  -- 'nvim-treesitter/nvim-treesitter-textobjects',
  -- 'nvim-treesitter/nvim-treesitter-refactor',
  -- 'nvim-treesitter/nvim-treesitter-context',
  -- 'nvim-treesitter/nvim-treesitter-highlight',
  -- { "tpope/vim-fugitive" },

  { "numToStr/Comment.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "neovim/nvim.net" },
  { "wolandark/vim-live-server" },
  {
    "mg979/vim-visual-multi",
    -- v,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = { ensure_installed = { "json5" }, indent = { enable = false } },
  -- },
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
}
