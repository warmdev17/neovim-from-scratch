require("nvim-highlight-colors").setup({
	render = "background", -- "background" | "foreground" | "virtual"
	enable_named_colors = true,
	enable_tailwind = true,

	virtual_symbol = "■",
	virtual_symbol_position = "inline",

	exclude_filetypes = {
		"lazy",
		"mason",
		"oil",
		"dbui",
	},
})
