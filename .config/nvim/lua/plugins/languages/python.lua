return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "ninja", "rst" } },
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
					keys = {
						{
							"<leader>co",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
					},
				},
				ruff_lsp = {
					keys = {
						{
							"<leader>co",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
					},
				},
			},
			setup = {
				["ruff"] = function()
					-- Define on_attach function directly
					local on_attach = function(client, _)
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end
					-- Create autocmd for our on_attach
					local name = "ruff"
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(args)
							local buffer = args.buf ---@type number
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							if client and (not name or client.name == name) then
								return on_attach(client, buffer)
							end
						end,
					})
				end,
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = function(_, opts)
				local servers = { "pyright", "basedpyright", "ruff", "ruff_lsp" }
				for _, server in ipairs(servers) do
					opts.servers[server] = opts.servers[server] or {}
					opts.servers[server].enabled = server == "pyright" or server == "ruff"
				end
			end,
		},
		{
			"nvim-neotest/neotest-python",
		},
		{
			"mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
			config = function()
				if vim.fn.has("win32") == 1 then
					require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
				else
					require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
				end
			end,
		},
		{
			"nvim-neotest/neotest",
			optional = true,
			dependencies = {
				"nvim-neotest/neotest-python",
			},
			opts = {
				adapters = {
					["neotest-python"] = {
						-- Here you can specify the settings for the adapter, i.e.
						-- runner = "pytest",
						-- python = ".venv/bin/python",
					},
				},
			},
		},
		{
			"mfussenegger/nvim-dap",
			optional = true,
			dependencies = {
				"mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
				config = function()
					if vim.fn.has("win32") == 1 then
						require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
					else
						require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
					end
				end,
			},
		},
		{
			"hrsh7th/nvim-cmp",
			optional = true,
			opts = function(_, opts)
				opts.auto_brackets = opts.auto_brackets or {}
				table.insert(opts.auto_brackets, "python")
			end,
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			optional = true,
			opts = {
				handlers = {
					python = function() end,
				},
			},
		},
	},
}
