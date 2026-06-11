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
		input = {
			border = "single",
			relative = "cursor",
			row = -3,
			col = 0,
			width = function()
				local word = vim.fn.expand("<cword>")
				return math.max(20, math.min(60, #word + 10))
			end,
		},
	},
})

local function countNormalWindows()
	local count = 0

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local config = vim.api.nvim_win_get_config(win)

		if config.relative == "" then
			count = count + 1
		end
	end

	return count
end

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
		["q"] = function()
			if countNormalWindows() > 1 then
				vim.cmd("close")
			else
				vim.cmd("quitall")
			end
		end,
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
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				silent = true,
				desc = desc,
			})
		end

		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
				return
			end

			gitsigns.nav_hunk("next")
		end, "Next Hunk")

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
				return
			end

			gitsigns.nav_hunk("prev")
		end, "Previous Hunk")

		map("n", "<leader>gh", gitsigns.preview_hunk, "Preview Hunk")
		map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Hunk")
		map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Hunk")

		map("v", "<leader>gs", function()
			gitsigns.stage_hunk({
				vim.fn.line("."),
				vim.fn.line("v"),
			})
		end, "Stage Selected Hunk")

		map("v", "<leader>gr", function()
			gitsigns.reset_hunk({
				vim.fn.line("."),
				vim.fn.line("v"),
			})
		end, "Reset Selected Hunk")

		map("n", "<leader>gH", function()
			gitsigns.setqflist("all")
			vim.cmd("copen")
		end, "Git Hunks Quickfix")

		map("n", "<leader>gb", function()
			gitsigns.blame_line({ full = true })
		end, "Git Blame Line")

		map("n", "<leader>gd", gitsigns.diffthis, "Git Diff This")

		map("n", "<leader>gD", function()
			gitsigns.diffthis("~")
		end, "Git Diff This ~")

		map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle Git Blame")
	end,
})

require("mini.comment").setup()
require("mini.pairs").setup()

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = "none",

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

	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},

		menu = {
			draw = {
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon

							if ctx.item.source_name == "LSP" then
								local colorItem = require("nvim-highlight-colors").format(ctx.item.documentation, {
									kind = ctx.kind,
								})

								if colorItem and colorItem.abbr ~= "" then
									icon = colorItem.abbr
								end
							end

							return icon .. ctx.icon_gap
						end,

						highlight = function(ctx)
							local highlight = "BlinkCmpKind" .. ctx.kind

							if ctx.item.source_name == "LSP" then
								local colorItem = require("nvim-highlight-colors").format(ctx.item.documentation, {
									kind = ctx.kind,
								})

								if colorItem and colorItem.abbr_hl_group then
									highlight = colorItem.abbr_hl_group
								end
							end

							return highlight
						end,
					},
				},
			},
		},
	},

	cmdline = {
		keymap = {
			preset = "cmdline",
			["<Tab>"] = { "accept" },
			["<Right>"] = false,
			["<Left>"] = false,
		},
		completion = {
			list = { selection = { preselect = true } },
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
			ghost_text = { enabled = true },
		},
	},
})

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

require("inc_rename").setup({
	input_buffer_type = "snacks",
})

require("flash").setup({
	labels = "asdfghjklqwertyuiopzxcvbnm",

	search = {
		enabled = false,
	},

	jump = {
		jumplist = true,
		pos = "start",
		history = false,
		register = false,
		nohlsearch = false,
		autojump = false,
	},

	label = {
		uppercase = true,
		exclude = "",
		current = true,
		after = true,
		before = false,
		style = "overlay",
		reuse = "lowercase",
		distance = true,
		min_pattern_length = 0,
		rainbow = {
			enabled = false,
		},
	},

	highlight = {
		backdrop = true,
		matches = true,
		priority = 5000,
		groups = {
			match = "FlashMatch",
			current = "FlashCurrent",
			backdrop = "FlashBackdrop",
			label = "FlashLabel",
		},
	},

	modes = {
		search = {
			enabled = false,
		},
		char = {
			enabled = true,
			jump_labels = true,
			multi_line = true,
		},
	},
})

require("treesitter-context").setup({
	max_lines = 3,
})

require("markview").setup({
	preview = {
		enable = true,
		filetypes = { "markdown", "md", "rmd", "quarto" },
		ignore_buftypes = {},
	},
})
