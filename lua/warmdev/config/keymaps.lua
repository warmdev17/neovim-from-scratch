local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_save_on_switch = 2

-- nohlsearch
map({ "n" }, "<Esc>", "<cmd>nohl<cr>", opts)

-- movement
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "J", "5j", opts)
map({ "n", "v" }, "K", "5k", opts)
map({ "n", "v", "o" }, "H", "^", opts)
map({ "n", "v", "o" }, "L", "$", opts)
map({ "n", "v" }, "<C-d>", "<C-d>zz", opts)
map({ "n", "v" }, "<C-u>", "<C-u>zz", opts)

-- window resize
map("n", "<leader>h", "<cmd>vertical resize -2<cr>")
map("n", "<leader>l", "<cmd>vertical resize +2<cr>")
map("n", "<leader>j", "<cmd>resize +2<cr>")
map("n", "<leader>k", "<cmd>resize -2<cr>")

-- Move line up/down
map("n", "<A-j>", "<cmd>move .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>move .-2<cr>==", { desc = "Move Line Up" })

map("v", "<A-j>", ":move '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":move '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- Indent line/selection
map("n", "<A-h>", "<<", { desc = "Indent Line Left" })
map("n", "<A-l>", ">>", { desc = "Indent Line Right" })

map("v", "<A-h>", "<gv", { desc = "Indent Selection Left" })
map("v", "<A-l>", ">gv", { desc = "Indent Selection Right" })

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
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = false })
end, { desc = "Next diagnostic" })

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = false })
end, { desc = "Previous diagnostic" })

map("n", "<leader>d", "dd", { desc = "Delete line" })
map({ "n", "v" }, "<c-a>", "ggVG", opts) -- select all
map("n", "+", "<C-a>", opts) -- increment
map("n", "-", "<C-x>", opts) -- decrement
map("n", "dw", "vb_d", opts) -- delete word backward
map({ "n", "v" }, "x", '"_x', opts) -- delete without yank
