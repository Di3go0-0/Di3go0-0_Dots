return {
	{
		"hrsh7th/nvim-cmp",
		dependences = {
			"hrsh7th/cmp-nvim-lsp",
			"cmp-cmp.lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-git",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-copilot",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"windwp/nvim-autopairs",
		},
		opts = function(_, opts)
			local cmp = require("cmp")

			-- Variable para rastrear el estado de autocompletado
			local autocomplete_enabled = true

			-- Función para alternar autocompletado
			local function toggle_autocomplete(enable)
				autocomplete_enabled = enable
				cmp.setup({
					completion = {
						autocomplete = enable and { cmp.TriggerEvent.TextChanged } or {}, -- Autocompletar solo si está habilitado
					},
				})
			end

			-- Activamos el autocompletado automático inicialmente
			toggle_autocomplete(true)

			-- Configuración de mapeos
			opts.mapping = {
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Space>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.close()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- Mapeo para cerrar el menú de autocompletado y desactivar autocompletado automático
				["<C-e>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.close()
						toggle_autocomplete(false) -- Desactiva el autocompletado
					else
						fallback()
					end
				end),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- Mapeo para abrir el menú de autocompletado y reactivar el autocompletado automático
				["<C-Space>"] = cmp.mapping(function()
					cmp.complete()
					toggle_autocomplete(true) -- Reactiva el autocompletado automático
				end),
			}

			-- Fuentes de autocompletado
			opts.sources = cmp.config.sources({
				{ name = "copilot", priority = 1000 },
				{ name = "nvim_lsp", priority = 750 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 250 },
				{ name = "luasnip", priority = 300 },
				{ name = "emmet_nvim" },
			})

			-- Configuración de íconos para cada tipo de fuente
			opts.formatting = {
				format = function(entry, vim_item)
					local icons = {
						copilot = "",
						nvim_lsp = "",
						buffer = "﬘",
						path = "",
						luasnip = "",
						emmet_nvim = "",
					}
					vim_item.kind = string.format("%s %s", icons[entry.source.name], vim_item.kind)
					return vim_item
				end,
			}

			-- Configuración de ventanas de autocompletado y documentación
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
