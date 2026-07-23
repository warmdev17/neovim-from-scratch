require("markview").setup({
	preview = {
		enable = true,
		icon_provider = "mini",
		filetypes = { "markdown", "md", "rmd", "quarto" },
		ignore_buftypes = {},
	},
	html = {
		enable = true,
		headings = {
			enable = true,
		},
		void_elements = {
			enable = true,
		},
	},
})
