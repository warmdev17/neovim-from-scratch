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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor position",
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		local filetype = vim.bo[buf].filetype

		if vim.tbl_contains(exclude, filetype) then
			return
		end

		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lineCount = vim.api.nvim_buf_line_count(buf)

		if mark[1] > 0 and mark[1] <= lineCount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
