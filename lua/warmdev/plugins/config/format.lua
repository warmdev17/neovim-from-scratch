local map = vim.keymap.set

require("conform").setup({
	formatters = {
		kulala = {
			command = "kulala-fmt",
			args = { "format", "$FILENAME" },
			stdin = false,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },

		go = { "goimports", "gofmt" },

		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },

		json = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		markdown = { "prettierd" },
		yaml = { "prettierd" },

		python = { "black" },

		http = { "kulala" },
		rest = { "kulala" },

		sql = { "pg_format" },
	},

	format_on_save = function(bufnr)
		if vim.g.disableAutoformat or vim.b[bufnr].disableAutoformat then
			return
		end

		return {
			timeout_ms = 500,
			lsp_format = "fallback",
		}
	end,
})

local lint = require("lint")

lint.linters_by_ft = {
	go = { "golangcilint" },

	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },

	python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

map({ "n", "v" }, "<leader>lf", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
	})
end, { desc = "Format file" })

-- disable format on save
map("n", "<leader>uf", function()
	vim.g.disableAutoformat = not vim.g.disableAutoformat

	if vim.g.disableAutoformat then
		vim.notify("Format on save disabled")
	else
		vim.notify("Format on save enabled")
	end
end, { desc = "Toggle format on save" })

-- disable buffer format on save
map("n", "<leader>uF", function()
	vim.b.disableAutoformat = not vim.b.disableAutoformat

	if vim.b.disableAutoformat then
		vim.notify("Format on save disabled for this buffer")
	else
		vim.notify("Format on save enabled for this buffer")
	end
end, { desc = "Toggle format on save buffer" })
