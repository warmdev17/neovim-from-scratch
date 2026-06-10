require("snacks").setup({
	picker = {
		enabled = true,
		layouts = {
			default = {
				layout = {
					box = "horizontal",
					width = 0.8,
					min_width = 120,
					height = 0.8,

					{
						box = "vertical",
						border = "single",
						title = "{title} {live} {flags}",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
					},

					{
						win = "preview",
						title = "{preview}",
						border = "single",
						width = 0.5,
					},
				},
			},

			vertical = {
				layout = {
					backdrop = false,
					width = 0.5,
					min_width = 80,
					height = 0.8,
					min_height = 30,
					box = "vertical",
					border = "single",
					title = "{title} {live} {flags}",
					title_pos = "center",

					{ win = "input", height = 1, border = "bottom" },
					{ win = "list", border = "none" },
					{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
				},
			},
		},
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
		win = {
			border = "single",
			width = 0.85,
			height = 0.85,
		},
	},
	statuscolumn = {
		enabled = true,
		left = { "sign" },
		right = { "git" },
		folds = {
			open = true,
			git_hl = true,
		},
	},

	styles = {
		terminal = {
			border = "single",
			wo = {
				winhighlight = table.concat({
					"Normal:NormalFloat",
					"NormalNC:NormalFloat",
					"FloatBorder:FloatBorder",
				}, ","),
			},
		},

		lazygit = {
			border = "single",
			wo = {
				winhighlight = table.concat({
					"Normal:NormalFloat",
					"NormalNC:NormalFloat",
					"FloatBorder:FloatBorder",
				}, ","),
			},
		},
	},
})

require("oil").setup({
	default_file_explorer = true,
	watch_for_changes = true,
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

require("oil-git").setup()

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
		["<Tab>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },

		["<C-e>"] = { "cancel", "fallback" },

		["<A-l>"] = { "snippet_forward" },
		["<A-h>"] = { "snippet_backward" },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	snippets = {
		preset = "luasnip",
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

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("Comment").setup({
	pre_hook = function(ctx)
		return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
	end,
})

require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
})
