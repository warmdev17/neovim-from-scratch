require("catppuccin").setup({
	flavour = "mocha",
	transparent = false,
	float = {
		transparent = false,
		solid = true,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
	},
	integrations = {
		bufferline = true,
		notify = true,
		gitsigns = true,
		mason = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		snacks = {
			enabled = true,
			indentscope_color = "",
		},
	},
	custom_highlights = function(colors)
		return {
			FloatBorder = { fg = colors.blue, bg = colors.mantle },
		}
	end,
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd("highlight DiagnosticUnderlineError gui=undercurl")
vim.cmd("highlight DiagnosticUnderlineWarn gui=undercurl")
vim.cmd("highlight DiagnosticUnderlineInfo gui=undercurl")
vim.cmd("highlight DiagnosticUnderlineHint gui=undercurl")

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#f38ba8" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#a6e3a1" })
