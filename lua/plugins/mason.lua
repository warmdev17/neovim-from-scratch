require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"vtsls",
		"html",
		"cssls",
		"jsonls",
		"tailwindcss",
	},

	automatic_enable = false,
})
