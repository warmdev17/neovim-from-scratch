local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"bash",
	"html",
	"css",
	"c",
	"java",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"http",
	"sql",
}

vim.api.nvim_create_user_command("TSInstallWarm", function()
	treesitter.install(ensure_installed)
end, {})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
