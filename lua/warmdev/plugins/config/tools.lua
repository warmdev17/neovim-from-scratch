local map = vim.keymap.set

require("kulala").setup({
	global_keymaps = false,
	global_keymaps_prefix = "<leader>r",
	kulala_keymaps_prefix = "",

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "kulala_ui",
		callback = function(event)
			local mapOpts = { buffer = event.buf, silent = true, noremap = true }

			vim.keymap.set("n", "<C-h>", "<C-w>h", mapOpts)
			vim.keymap.set("n", "<C-j>", "<C-w>j", mapOpts)
			vim.keymap.set("n", "<C-k>", "<C-w>k", mapOpts)
			vim.keymap.set("n", "<C-l>", "<C-w>l", mapOpts)
		end,
	}),
})

require("todo-comments").setup({
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
})

map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

map("n", "<leader>st", function()
	local curr_path = vim.fn.expand("%:p")
	Snacks.picker.todo_comments({
		transform = function(item)
			local item_path = vim.fn.fnamemodify(item.cwd .. "/" .. item.file, ":p")
			return item_path == curr_path
		end,
	})
end, { desc = "Todo" })

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod-ui"

vim.g.db_ui_table_helpers = {
	postgresql = {
		Count = "select count(*) from {table}",
		Explain = "explain analyze select * from {table}",
		List = "select * from {table} limit 20",
	},
}

vim.g.live_server = {
	port = 3000,
	browser = true,
}

map("n", "<leader>rr", function()
	require("kulala").run()
end, { desc = "Run request" })

map("n", "<leader>ra", function()
	require("kulala").run_all()
end, { desc = "Run all requests" })

map("n", "<leader>rb", function()
	require("kulala").scratchpad()
end, { desc = "Open request scratchpad" })

map("n", "<leader>re", function()
	require("kulala").set_selected_env()
end, { desc = "Select request env" })

map("n", "<leader>ri", function()
	require("kulala").inspect()
end, { desc = "Inspect request" })

map("n", "<leader>Du", "<cmd>DBUIToggle<cr>", { desc = "Toggle DB UI" })
map("n", "<leader>Df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB buffer" })
map("n", "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Rename DB buffer" })
map("n", "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", { desc = "Last DB query info" })
