local editorModules = {
	"oil",
	"gitsigns",
	"tmux",
	"flash",
	"mini",
	"silicon",
}

for _, module in ipairs(editorModules) do
	require("warmdev.plugins.config.editor." .. module)
end

require("markview").setup({
	preview = {
		enable = true,
		filetypes = { "markdown", "md", "rmd", "quarto" },
		ignore_buftypes = {},
	},
})
