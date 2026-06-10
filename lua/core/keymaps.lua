local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_save_on_switch = 2

-- movement
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "J", "5j", opts)
map({ "n", "v" }, "K", "5k", opts)
map({ "n", "v", "o" }, "H", "^", opts)
map({ "n", "v", "o" }, "L", "$", opts)
map({ "n", "v" }, "<C-d>", "<C-d>zz", opts)
map({ "n", "v" }, "<C-u>", "<C-u>zz", opts)

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

map("n", "<leader>cd", function()
	Snacks.picker.diagnostics()
end, { desc = "Workspace Diagnostics" })

map("n", "<leader>cD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })

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

-- disable format on save
map("n", "<leader>uf", function()
	vim.g.disableAutoformat = not vim.g.disableAutoformat

	if vim.g.disableAutoformat then
		vim.notify("Format on save disabled")
	else
		vim.notify("Format on save enabled")
	end
end, { desc = "Toggle format on save" })

-- disable buffer format on save
map("n", "<leader>uF", function()
	vim.b.disableAutoformat = not vim.b.disableAutoformat

	if vim.b.disableAutoformat then
		vim.notify("Format on save disabled for this buffer")
	else
		vim.notify("Format on save enabled for this buffer")
	end
end, { desc = "Toggle format on save buffer" })

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

local incRenamePrefix = "IncRename "

local function isIncRenameCmdline()
	local cmdType = vim.fn.getcmdtype()
	local cmdLine = vim.fn.getcmdline()

	return cmdType == ":" and vim.startswith(cmdLine, incRenamePrefix)
end

local function isAtIncRenamePrefix()
	local cmdLine = vim.fn.getcmdline()
	local cmdPos = vim.fn.getcmdpos()

	return isIncRenameCmdline() and #cmdLine <= #incRenamePrefix and cmdPos <= #incRenamePrefix + 1
end

map("c", "<BS>", function()
	if isAtIncRenamePrefix() then
		return ""
	end

	return "<BS>"
end, { expr = true, desc = "Protected backspace for IncRename" })

map("c", "<C-w>", function()
	if isAtIncRenamePrefix() then
		return ""
	end

	return "<C-w>"
end, { expr = true, desc = "Protected delete word for IncRename" })

map("c", "<C-u>", function()
	if isIncRenameCmdline() then
		return incRenamePrefix
	end

	return "<C-u>"
end, { expr = true, desc = "Protected clear line for IncRename" })

map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, {
	expr = true,
	desc = "Rename",
})

local tmuxNavigatorOpts = { silent = true }

-- tmux navigator
map(
	"n",
	"<C-h>",
	"<cmd>TmuxNavigateLeft<cr>",
	vim.tbl_extend("force", tmuxNavigatorOpts, {
		desc = "Navigate Left",
	})
)

map(
	"n",
	"<C-j>",
	"<cmd>TmuxNavigateDown<cr>",
	vim.tbl_extend("force", tmuxNavigatorOpts, {
		desc = "Navigate Down",
	})
)

map(
	"n",
	"<C-k>",
	"<cmd>TmuxNavigateUp<cr>",
	vim.tbl_extend("force", tmuxNavigatorOpts, {
		desc = "Navigate Up",
	})
)

map(
	"n",
	"<C-l>",
	"<cmd>TmuxNavigateRight<cr>",
	vim.tbl_extend("force", tmuxNavigatorOpts, {
		desc = "Navigate Right",
	})
)

map(
	"n",
	"<C-\\>",
	"<cmd>TmuxNavigatePrevious<cr>",
	vim.tbl_extend("force", tmuxNavigatorOpts, {
		desc = "Navigate Previous",
	})
)

-- flash
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

map("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

map("c", "<C-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
