-- Disable "No information available" notification on hover
-- plus define border for hover window
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = config
		or {
			border = {
				{ "╭", "Comment" },
				{ "─", "Comment" },
				{ "╮", "Comment" },
				{ "│", "Comment" },
				{ "╯", "Comment" },
				{ "─", "Comment" },
				{ "╰", "Comment" },
				{ "│", "Comment" },
			},
		}
	config.focus_id = ctx.method
	if not (result and result.contents) then
		return
	end
	local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
	if vim.tbl_isempty(markdown_lines) then
		return
	end
	return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

-- Custom handler for signature help to prevent TypeScript server errors
vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
	-- Guard against errors with a pcall
	local status, result_or_err = pcall(function()
		config = config
			or {
				border = {
					{ "╭", "Comment" },
					{ "─", "Comment" },
					{ "╮", "Comment" },
					{ "│", "Comment" },
					{ "╯", "Comment" },
					{ "─", "Comment" },
					{ "╰", "Comment" },
					{ "│", "Comment" },
				},
			}
		config.focus_id = ctx.method

		if not (result and result.signatures and #result.signatures > 0) then
			return
		end

		local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.signatures)
		markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

		if vim.tbl_isempty(markdown_lines) then
			return
		end

		return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
	end)

	if not status then
		-- Si hay error, no hacemos nada y evitamos que la excepción se propague
		-- print("Error en signature help:", result_or_err)
		return
	end

	return result_or_err
end

-- Importa las capacidades de autocompletado de `nvim-cmp` en LSP
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Configuración de servidores LSP
return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				cssls = {
					capabilities = capabilities,
					settings = {
						css = { validate = true },
						less = { validate = true },
						scss = { validate = true },
					},
				},
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
					},
				},
			},
		},
	},
} -- vim: ts=2 sts=2 sw=2 et
