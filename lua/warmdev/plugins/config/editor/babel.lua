require("babel").setup({
	source = "auto",
	target = "vi",
	provider = "google",

	display = "float",
	picker = "snacks",

	float = {
		border = "single",
		mode = "cursor",
		max_width = 70,
		max_height = 12,
		enter = true,
		auto_close = false,
		copy_original = true,
	},

	keymaps = {
		translate = "<leader>tr",
		translate_word = "<leader>tw",
		lang = "<leader>tl",
		swap = "<leader>ts",
		history = "<leader>th",
	},
})
