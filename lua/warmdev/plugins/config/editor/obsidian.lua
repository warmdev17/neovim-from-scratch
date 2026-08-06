require("obsidian").setup({
	legacy_commands = false,
	note_id_func = require("obsidian.builtin").title_id,
	picker = {
		name = "snacks.picker",
	},
	workspaces = {
		{
			name = "Road to Devops",
			path = "~/vault/Learn",
		},
	},
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
	callback = function()
		local cmdline = vim.fn.getcmdline()
		if vim.fn.getcmdtype() ~= ":" then
			return
		end
		if not cmdline:match("^Obsidian[A-Za-z0-9]*$") then
			return
		end
		vim.fn.wildtrigger()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "ObsidianNoteWritePost",
	callback = function(ev)
		require("conform").format({
			bufnr = ev.buf,
			formatters = { "prettierd", "injected" },
		})
	end,
})
