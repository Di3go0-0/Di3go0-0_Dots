-- This file contains the configuration for setting up the lazy.nvim plugin manager in Neovim.

-- Define the path to the lazy.nvim plugin
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if the lazy.nvim plugin is not already installed
if not vim.loop.fs_stat(lazypath) then
  -- Bootstrap lazy.nvim by cloning the repository
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

-- Prepend the lazy.nvim path to the runtime path
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- WSL copy paste with win32yank
-- if vim.fn.has("wsl") == 1 then
-- 	vim.g.clipboard = {
-- 		name = "win32yank",
-- 		copy = {
-- 			["+"] = "win32yank.exe -i --crlf",
-- 			["*"] = "win32yank.exe -i --crlf",
-- 		},
-- 		paste = {
-- 			["+"] = "win32yank.exe -o --lf",
-- 			["*"] = "win32yank.exe -o --lf",
-- 		},
-- 		cache_enabled = false,
-- 	}
-- end

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- import any extra modules here
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.editor.harpoon2" },
		{ import = "lazyvim.plugins.extras.coding.mini-surround" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		{ import = "lazyvim.plugins.extras.coding.nvim-cmp" }, -- Intall by :Lazyextras
		-- Others
		--
		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot of the plugins that support versioning
		-- have outdated releases, which may break your Neovim install.
		version = false, -- Always use the latest git commit
		-- version = "*", -- Try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight", "habamax" } }, -- Specify colorschemes to install
	checker = { enabled = false }, -- Automatically check for plugin updates
	performance = {
		rtp = {
			-- Disable some runtime path plugins to improve performance
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
