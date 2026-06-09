-- disable linenumber for dbui and dbout
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"dbui",
		"dbout",
	},
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.statuscolumn = ""
	end,
})
