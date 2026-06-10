local github = "https://github.com/"

vim.pack.add({
	{ src = github .. "catppuccin/nvim", name = "catppuccin" },
	{ src = github .. "nvim-lualine/lualine.nvim" },
	{ src = github .. "akinsho/bufferline.nvim" },
	{ src = github .. "nvim-tree/nvim-web-devicons" },
	{ src = github .. "echasnovski/mini.icons" },
	{ src = github .. "brenoprata10/nvim-highlight-colors" },

	-- editor
	{ src = github .. "folke/snacks.nvim" },
	{ src = github .. "stevearc/oil.nvim" },
	{ src = github .. "malewicz1337/oil-git.nvim" },
	{ src = github .. "lewis6991/gitsigns.nvim" },
	{ src = github .. "nvim-mini/mini.comment" },
	{ src = github .. "folke/flash.nvim" },
	{ src = github .. "nvim-mini/mini.pairs" },
	{ src = github .. "christoomey/vim-tmux-navigator" },
	{ src = github .. "nvim-treesitter/nvim-treesitter-context" },
	{ src = github .. "OXY2DEV/markview.nvim" },

	-- lsp
	{ src = github .. "nvim-treesitter/nvim-treesitter" },
	{ src = github .. "neovim/nvim-lspconfig" },
	{ src = github .. "mason-org/mason.nvim" },
	{ src = github .. "mason-org/mason-lspconfig.nvim" },
	{ src = github .. "b0o/SchemaStore.nvim" },

	-- completion
	{ src = github .. "saghen/blink.lib" },
	{ src = github .. "saghen/blink.cmp" },
	{ src = github .. "stevearc/conform.nvim" },

	-- linter
	{ src = github .. "mfussenegger/nvim-lint" },

	-- rest http
	{ src = github .. "mistweaverco/kulala.nvim" },

	-- database
	{ src = github .. "tpope/vim-dadbod" },
	{ src = github .. "kristijanhusak/vim-dadbod-ui" },
	{ src = github .. "kristijanhusak/vim-dadbod-completion" },

	-- comment
	{ src = github .. "numToStr/Comment.nvim" },
	{ src = github .. "JoosepAlviste/nvim-ts-context-commentstring" },
	{ src = github .. "windwp/nvim-ts-autotag" },

	-- tiny diagnostic
	{ src = github .. "rachartier/tiny-inline-diagnostic.nvim" },

	-- snippet
	{ src = github .. "L3MON4D3/LuaSnip" },
	{ src = github .. "rafamadriz/friendly-snippets" },

	-- inc-rename
	{ src = github .. "smjonas/inc-rename.nvim" },

	-- which key
	{ src = github .. "folke/which-key.nvim" },
})
