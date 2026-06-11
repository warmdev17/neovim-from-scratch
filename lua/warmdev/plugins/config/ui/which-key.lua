local wk = require("which-key")

wk.add({
	{ "<leader>f", group = "find" },
	{ "<leader>g", group = "git" },
	{ "<leader>c", group = "code" },
	{ "<leader>l", group = "lint/format" },
	{ "<leader>r", group = "rest" },
	{ "<leader>d", group = "debug/database" },
	{ "<leader>t", group = "terminal/test" },
})

wk.setup({
	preset = "modern",
	delay = 300,

	win = {
		border = "single",
		padding = { 1, 2 },
		title = true,
		title_pos = "center",

		row = -1,
		col = math.huge,

		width = { min = 35, max = 50 },
		height = { min = 4, max = 14 },

		no_overlap = false,
	},

	layout = {
		width = { min = 20, max = 30 },
		spacing = 3,
	},

	icons = {
		mappings = false,
		group = "+",
		separator = "➜",
	},
})
