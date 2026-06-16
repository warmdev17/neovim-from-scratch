local map = vim.keymap.set

require("kulala").setup({
	global_keymaps = false,
	global_keymaps_prefix = "<leader>r",
	kulala_keymaps_prefix = "",
})

require("todo-comments").setup()

map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

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
