local supported = {
	"css",
	"graphql",
	"handlebars",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"less",
	"markdown",
	"markdown.mdx",
	"scss",
	"typescript",
	"typescriptreact",
	"vue",
	"yaml",
}

return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			-- 1. Configuración de formateadores por tipo de archivo
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.lua = { "stylua" }

			for _, ft in ipairs(supported) do
				-- { { "a", "b" } } significa: intenta con 'a', si no está, usa 'b'
				opts.formatters_by_ft[ft] = { { "prettierd", "prettier" } }
			end

			-- 2. Configuración de Formateo al Guardar
			-- Cambiamos format_after_save por format_on_save según tu requerimiento
			opts.format_on_save = function(bufnr)
				-- Aquí puedes añadir lógica extra, por ejemplo, para ignorar archivos grandes
				return {
					timeout_ms = 500,
					lsp_fallback = true,
					quiet = true,
				}
			end

			-- Opcional: Si quieres mantener format_after_save en false para evitar conflictos
			opts.format_after_save = false
		end,
	},
}
