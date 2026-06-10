local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("gopls", {
	capabilities = capabilities,

	init_options = {
		semanticTokens = true,
	},

	settings = {
		gopls = {
			semanticTokens = true,
			gofumpt = true,
			staticcheck = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

vim.lsp.config("vtsls", {
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
})

vim.lsp.enable({
	"gopls",
	"vtsls",
	"lua_ls",
	"html",
	"cssls",
	"jsonls",
	"tailwindcss",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client or client.name ~= "gopls" then
			return
		end

		if
			client.config.init_options
			and client.config.init_options.semanticTokens
			and not client.server_capabilities.semanticTokensProvider
		then
			local semanticTokens = client.config.capabilities.textDocument.semanticTokens

			client.server_capabilities.semanticTokensProvider = {
				full = true,
				range = true,
				legend = {
					tokenTypes = semanticTokens.tokenTypes,
					tokenModifiers = semanticTokens.tokenModifiers,
				},
			}
		end
	end,
})
