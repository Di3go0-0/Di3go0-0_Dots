return {
  -- 'nvim-treesitter/nvim-treesitter',
  -- 'nvim-treesitter/playground',
  -- 'nvim-treesitter/nvim-treesitter-textobjects',
  -- 'nvim-treesitter/nvim-treesitter-refactor',
  -- 'nvim-treesitter/nvim-treesitter-context',
  -- 'nvim-treesitter/nvim-treesitter-highlight',
  { "numToStr/Comment.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "neovim/nvim.net" },
  { "wolandark/vim-live-server" },

  -- { "tpope/vim-fugitive" },
}
