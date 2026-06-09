require("snacks").setup({
	picker = {
		enabled = true,
	},
	explorer = {
		enabled = false,
	},
	input = {
		enabled = true,
	},
	notifier = {
		enabled = true,
	},
	terminal = {
		enabled = true,
		win = {
			position = "float",
			border = "single",
			width = 0.8,
			height = 0.8,
		},
	},
	lazygit = {
		enabled = true,
	},
})

require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
	},
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["q"] = "actions.close",
		["<C-t>"] = false,
	},
})

require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
})

require("mini.comment").setup()
require("mini.pairs").setup()

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = "none",

		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

		["<CR>"] = { "accept", "fallback" },

		["<C-e>"] = { "hide" },

		["<C-n>"] = { "snippet_forward" },
		["<C-p>"] = { "snippet_backward" },

		["<C-b>"] = { "scroll_documentation_up" },
		["<C-f>"] = { "scroll_documentation_down" },

		["<Tab>"] = { "select_next", "fallback" },

		["<S-Tab>"] = { "select_prev", "fallback" },
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },

		go = { "goimports", "gofmt" },

		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },

		json = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

local lint = require("lint")

lint.linters_by_ft = {
	go = { "golangcilint" },

	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

require("kulala").setup({
	global_keymaps = false,
	global_keymaps_prefix = "<leader>r",
	kulala_keymaps_prefix = "",
})

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod-ui"

vim.g.db_ui_table_helpers = {
	postgresql = {
		Count = "select count(*) from {table}",
		Explain = "explain analyze select * from {table}",
		List = "select * from {table} limit 20",
	},
}
