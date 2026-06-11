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

local map = vim.keymap.set

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

map("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

map("c", "<C-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
