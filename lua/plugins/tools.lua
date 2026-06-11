require("babel").setup({
	source = "auto",
	target = "vi",
	provider = "google",

	network = {
		connect_timeout = 5,
		request_timeout = 15,
	},

	cache = {
		enabled = true,
		limit = 200,
	},

	history = {
		enabled = true,
		limit = 20,
	},

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
		translate = "<leader>tt",
		translate_word = "<leader>tw",
		lang = "<leader>tl",
		swap = "<leader>ts",
		history = "<leader>th",
	},
})
