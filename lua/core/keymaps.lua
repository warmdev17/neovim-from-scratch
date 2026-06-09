local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- movement
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "J", "5j", opts)
map({ "n", "v" }, "K", "5k", opts)
map({ "n", "v", "o" }, "H", "^", opts)
map({ "n", "v", "o" }, "L", "$", opts)

-- pane movement
map({ "n", "v" }, "<C-h>", "<C-w>h", opts)
map({ "n", "v" }, "<C-j>", "<C-w>j", opts)
map({ "n", "v" }, "<C-k>", "<C-w>k", opts)
map({ "n", "v" }, "<C-l>", "<C-w>l", opts)

-- buffer movement
map("n", "<tab>", ":bnext<cr>", opts)
map("n", "<s-tab>", ":bprev<cr>", opts)

-- buffer delete
map("n", "bd", ":bdelete<cr>", opts)

-- pane split
map("n", "ss", ":split<cr>", opts)
map("n", "sv", ":vsplit<cr>", opts)

-- diagnostic
map("n", "<c-d>", function()
	vim.diagnostic.jump({ count = 1 })
end, opts)

map("n", "<leader>d", "dd", { desc = "Delete line" })
map({ "n", "v" }, "<c-a>", "ggVG", opts) -- select all
map("n", "+", "<C-a>", opts) -- increment
map("n", "-", "<C-x>", opts) -- decrement
map("n", "dw", "vb_d", opts) -- delete word backward
map({ "n", "v" }, "x", '"_x', opts) -- delete without yank

-- snacks
map("n", "<leader><leader>", function()
	Snacks.picker.files()
end, { desc = "Find files" })

map("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })

map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Find buffers" })

map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent files" })

map("n", "<leader>e", function()
	require("oil").open()
end, { desc = "Open Oil" })

map({ "n", "t" }, "<C-t>", function()
	Snacks.terminal()
end, { desc = "Toggle float terminal" })

map("n", "<leader>gg", function()
	Snacks.lazygit.open()
end, { desc = "Open LazyGit" })

map("n", "<leader>gb", function()
	require("gitsigns").blame_line()
end, { desc = "Git blame line" })

map("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Git preview hunk" })

map("n", "<leader>gr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Git reset hunk" })

map({ "n", "v" }, "<leader>lf", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
	})
end, { desc = "Format file" })

vim.keymap.set("n", "<leader>rr", function()
	require("kulala").run()
end, { desc = "Run request" })

vim.keymap.set("n", "<leader>ra", function()
	require("kulala").run_all()
end, { desc = "Run all requests" })

vim.keymap.set("n", "<leader>rb", function()
	require("kulala").scratchpad()
end, { desc = "Open request scratchpad" })

vim.keymap.set("n", "<leader>re", function()
	require("kulala").set_selected_env()
end, { desc = "Select request env" })

vim.keymap.set("n", "<leader>ri", function()
	require("kulala").inspect()
end, { desc = "Inspect request" })
