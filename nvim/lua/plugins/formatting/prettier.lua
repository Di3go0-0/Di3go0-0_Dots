local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

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
	-- "markdown",
	-- "markdown.mdx",
	"scss",
	-- "typescript",
	-- "typescriptreact",
	"vue",
	"yaml",
}

return {
	{
		"williamboman/mason.nvim",
		opts = { ensure_installed = { "prettier" } },
	},

	-- conform
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			for _, ft in ipairs(supported) do
				opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
				if file_exists(".prettierrc") or file_exists(".eslintrc.js") then
					table.insert(opts.formatters_by_ft[ft], "prettier")
				end
				table.insert(opts.formatters_by_ft[ft], "prettierd")
			end

			opts.format_after_save = function(bufnr)
				-- Disable formatting if global or buffer-local variable is set
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Check if the filetype supports `prettier`
				local filetype = vim.bo[bufnr].filetype

				if vim.tbl_contains(supported, filetype) then
					if file_exists(".prettierrc") or file_exists(".eslintrc.js") then
						return { formatters = { "prettier" }, timeout_ms = 2000 }
					end
				end

				-- Fallback to default LSP formatting
				return { lsp_format = "fallback" }
			end
		end,
	},

	-- none-ls support
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			if file_exists(".prettierrc") or file_exists(".eslintrc.js") then
				table.insert(opts.sources, nls.builtins.formatting.prettier)
			end
		end,
	},
}
