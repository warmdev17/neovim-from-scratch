local map = vim.keymap.set

local tmuxNavigatorOpts = { silent = true }

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
