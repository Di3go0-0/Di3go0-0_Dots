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

-- Tu archivo de conform simplificado
-- local supported = { "css", "graphql", "html", "javascript", "typescript", "typescriptreact", "vue" } -- etc

return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			for _, ft in ipairs(supported) do
				opts.formatters_by_ft[ft] = { { "prettierd", "prettier" } }
			end
		end,
	},
}
