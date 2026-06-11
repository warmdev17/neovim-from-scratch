require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"lua_ls",
		"vtsls",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
		"tailwindcss",
		"stylua",
		"pyright",
		"ruff",
	},

	automatic_enable = false,
})
