return {
	-- Plugin para omnisharp
	{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
	{ "Issafalcon/neotest-dotnet" },

	-- Configuración para null-ls con CSharpier
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			table.insert(opts.sources, nls.builtins.formatting.csharpier)
		end,
	},

	-- Integración de Conform para formatear C#
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
			},
			formatters = {
				csharpier = {
					command = "dotnet-csharpier",
					args = { "--write-stdout" },
				},
			},
		},
	},

	-- Integración de DAP para debugging en .NET
	{
		"mfussenegger/nvim-dap",
		optional = true,
		opts = function()
			local dap = require("dap")
			if not dap.adapters["netcoredbg"] then
				dap.adapters["netcoredbg"] = {
					type = "executable",
					command = vim.fn.exepath("netcoredbg"),
					args = { "--interpreter=vscode" },
					options = {
						detached = false,
					},
				}
			end
			for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
				if not dap.configurations[lang] then
					dap.configurations[lang] = {
						{
							type = "netcoredbg",
							name = "Launch file",
							request = "launch",
							program = function()
								return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
							end,
							cwd = "${workspaceFolder}",
						},
					}
				end
			end
		end,
	},

	-- Integración de Neotest para pruebas .NET
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"Issafalcon/neotest-dotnet",
		},
		opts = {
			adapters = {
				["neotest-dotnet"] = {
					-- Aquí puedes configurar opciones específicas para neotest-dotnet
				},
			},
		},
	},

	-- Integración de NuGet para completar paquetes
	{
		"nvim-cmp",
		dependencies = {
			"PasiBergman/cmp-nuget",
		},
		opts = function(_, opts)
			local nuget = require("cmp-nuget")
			nuget.setup({})

			table.insert(opts.sources, 1, {
				name = "nuget",
			})

			opts.formatting.format = function(entry, vim_item)
				if entry.source.name == "nuget" then
					vim_item.kind = "NuGet"
				end
				return vim_item
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				omnisharp = {
					cmd = {
						vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp",
						"--languageserver",
						"--hostPID",
						tostring(vim.fn.getpid()),
					},
					enable_import_completion = true,
					organize_imports_on_format = true,
					enable_roslyn_analyzers = true,
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(
							"*.sln",
							"*.csproj",
							"omnisharp.json",
							"function.json"
						)(fname)
					end,
					handlers = {
						["textDocument/definition"] = function(...)
							return require("omnisharp_extended").handler(...)
						end,
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
							ft = "cs",
						},
						{
							"<leader>cI",
							function()
								vim.lsp.buf.code_action({
									context = {
										only = { "quickfix", "refactor" },
										diagnostics = {},
									},
								})
							end,
							desc = "Quick Fix / Refactor",
							ft = "cs",
						},
						{
							"<leader>cF",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.fixAll" },
										diagnostics = {},
									},
								})
							end,
							desc = "Fix All Issues",
							ft = "cs",
						},
					},
					settings = {
						FormattingOptions = {
							EnableEditorConfigSupport = true,
							OrganizeImports = true,
						},
						MsBuild = {
							LoadProjectsOnDemand = nil,
						},
						RoslynExtensionsOptions = {
							EnableAnalyzersSupport = true,
							EnableImportCompletion = true,
							AnalyzeOpenDocumentsOnly = nil,
						},
						Sdk = {
							IncludePrereleases = true,
						},
						OmniSharp = {
							EnableImportCompletion = true,
							EnableAnalyzersSupport = true,
						},
					},
				},
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- Opciones por defecto, puedes ajustarlas
				size = 20,
				open_mapping = [[<c-t>]], -- Mapeo para abrir/cerrar la terminal
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 1,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float", -- 'horizontal', 'vertical', 'float'
				close_on_exit = true,
				shell = vim.o.shell,
				-- Comandos personalizados para diferentes tipos de terminal
				-- Por ejemplo, un comando dotnet:
				-- terms = {
				--   {
				--     name = "dotnet",
				--     cmd = {"dotnet"},
				--     dir = "git_dir",
				--     direction = "float",
				--     hidden = true
				--   }
				-- }
			})

			-- Función para ejecutar comandos dotnet en una terminal flotante
			vim.api.nvim_create_user_command("Dotnet", function(opts)
				-- Asegurarse de que opts.args sea una string válida
				local args = opts.args or ""
				if type(args) == "table" then
					args = table.concat(args, " ")
				end

				local term = require("toggleterm.terminal").Terminal:new({
					cmd = "dotnet " .. args,
					direction = "float",
					close_on_exit = false,
				})
				term:toggle()
			end, { nargs = "*", complete = "shellcmd", desc = "Run a dotnet command" })
		end,
	},
}
