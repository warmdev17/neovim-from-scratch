require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
	},
})

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"docker_compose_language_service",
		"docker_language_server",
		"eslint",
		"gopls",
		"lua_ls",
		"vtsls",
		"html",
		"cssls",
		"emmet_language_server",
		"jsonls",
		"yamlls",
		"tailwindcss",
		"stylua",
		"pyright",
		"ruff",
	},

	automatic_enable = false,
})

require("tiny-code-action").setup({})

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action({})
end, { noremap = true, silent = true })

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
				enable = false,
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

vim.lsp.config("emmet_language_server", {
	capabilities = capabilities,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"pug",
		"typescriptreact",
	},
})

vim.lsp.enable({
	"gopls",
	"vtsls",
	"lua_ls",
	"html",
	"cssls",
	"eslint",
	"jsonls",
	"emmet_language_server",
	"yamlls",
	"tailwindcss",
	"pyright",
	"ruff",
	"harper_ls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buf = args.buf

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = buf,
				silent = true,
				desc = desc,
			})
		end

		map("n", "K", function()
			vim.lsp.buf.hover({
				border = "single",
			})
		end, "Hover Documentation")

		map("n", "<leader>cs", function()
			vim.lsp.buf.signature_help({
				border = "single",
			})
		end, "Signature Help")

		map("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, "Goto Definition")

		map("n", "gr", function()
			Snacks.picker.lsp_references()
		end, "References")

		map("n", "gI", function()
			Snacks.picker.lsp_implementations()
		end, "Implementations")

		map("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, "Type Definitions")

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
