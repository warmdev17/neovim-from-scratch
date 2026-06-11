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

			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},

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

vim.lsp.config("jsonls", {
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = {
				enable = true,
			},
		},
	},
})

vim.lsp.config("yamlls", {
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
			validate = true,
			completion = true,
			hover = true,
		},
	},
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "Snacks" },
			},
			workspace = {
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
			},
			hint = {
				enable = true,
				arrayIndex = "Disable",
			},
			semantic = {
				enable = true,
			},
		},
	},
})

vim.lsp.config("pyright", {
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})

vim.lsp.config("ruff", {
	capabilities = capabilities,
	init_options = {
		settings = {
			lineLength = 100,
		},
	},
})

vim.lsp.enable({
	"gopls",
	"vtsls",
	"lua_ls",
	"html",
	"cssls",
	"jsonls",
	"yamlls",
	"tailwindcss",
	"pyright",
	"ruff",
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

require("luasnip.loaders.from_vscode").lazy_load()
