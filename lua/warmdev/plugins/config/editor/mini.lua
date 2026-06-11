require("mini.comment").setup()
require("mini.pairs").setup()

require("mini.surround").setup({
	mappings = {
		add = "gsa", -- add surrounding
		delete = "gsd", -- delete surrounding
		find = "gsf", -- find surrounding right
		find_left = "gsF", -- find surrounding left
		highlight = "gsh", -- highlight surrounding
		replace = "gsr", -- replace surrounding
		update_n_lines = "gsn", -- update search lines
	},
})

require("mini.animate").setup({
	cursor = {
		enable = false,
	},

	scroll = {
		enable = true,
	},

	resize = {
		enable = true,
	},

	open = {
		enable = false,
	},

	close = {
		enable = false,
	},
})
