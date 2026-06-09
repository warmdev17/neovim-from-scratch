vim.lsp.config("gopls", {
	settings = {
		gopls = {
			semanticTokens = true,
		},
	},
})

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"vtsls",
	"html",
	"cssls",
	"jsonls",
	"tailwindcss",
})
