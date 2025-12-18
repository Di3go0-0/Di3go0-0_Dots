return {
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		-- CORRECCIÓN: 'dependencies' con 'i'
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-git",
			"hrsh7th/cmp-cmdline",
			-- "zbirenbaum/copilot-cmp",
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

				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

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

				-- Mapeo para abrir el menú de autocompletado y reactivar el autocompletado automático
				["<C-Space>"] = cmp.mapping(function()
					cmp.complete()
					toggle_autocomplete(true) -- Reactiva el autocompletado automático
				end),
			}

			-- Fuentes de autocompletado
			opts.sources = cmp.config.sources({
				-- { name = "copilot", priority = 1000 }, -- Ahora sí funcionará
				{ name = "nvim_lsp", priority = 750 },
				{ name = "luasnip", priority = 500 },
				{ name = "buffer", priority = 250 },
				{ name = "path", priority = 100 },
			})
			-- Configuración específica para archivos SQL
			cmp.setup.filetype({ "sql" }, {
				sources = cmp.config.sources({
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				}),
			})

			-- Configuración de íconos para cada tipo de fuente
			opts.formatting = {
				format = function(entry, vim_item)
					local icons = {
						-- copilot = "",
						nvim_lsp = "",
						buffer = "﬘",
						path = "",
						luasnip = "",
					}
					local icon = icons[entry.source.name] or " "
					vim_item.kind = string.format("%s %s", icon, vim_item.kind)
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
