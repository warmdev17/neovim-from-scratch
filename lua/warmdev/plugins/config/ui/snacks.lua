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

local map = vim.keymap.set

map("n", "<leader><leader>", function()
	Snacks.picker.files()
end, { desc = "Find files" })

map("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })

map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Find buffers" })

map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent files" })

map({ "n", "t" }, "<C-t>", function()
	Snacks.terminal()
end, { desc = "Toggle float terminal" })

map("n", "<leader>gg", function()
	Snacks.lazygit.open()
end, { desc = "Open LazyGit" })

map("n", "<leader>cd", function()
	Snacks.picker.diagnostics()
end, { desc = "Workspace Diagnostics" })

map("n", "<leader>cD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
