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

	-- lsp
	{ src = github .. "nvim-treesitter/nvim-treesitter" },
	{ src = github .. "neovim/nvim-lspconfig" },
	{ src = github .. "mason-org/mason.nvim" },
	{ src = github .. "mason-org/mason-lspconfig.nvim" },

	-- completion
	{ src = github .. "saghen/blink.lib" },
	{ src = github .. "saghen/blink.cmp" },
	{ src = github .. "stevearc/conform.nvim" },
})
