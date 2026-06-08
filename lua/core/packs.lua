local github = "https://github.com/"

vim.pack.add({
	{ src = github .. "catppuccin/nvim", name = "catppuccin" },
	{ src = github .. "nvim-lualine/lualine.nvim" },
	{ src = github .. "akinsho/bufferline.nvim" },
	{ src = github .. "nvim-tree/nvim-web-devicons" },
	{ src = github .. "echasnovski/mini.icons" },

	-- editor
	{ src = github .. "folke/snacks.nvim" },
	{ src = github .. "stevearc/oil.nvim" },
	{ src = github .. "lewis6991/gitsigns.nvim" },
	{ src = github .. "nvim-mini/mini.comment" },
	{ src = github .. "nvim-mini/mini.pairs" },
})
