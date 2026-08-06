require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
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
		lazygit = true,
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

require("mini.icons").setup({
	style = "glyph",
})

require("mini.icons").mock_nvim_web_devicons()

require("tiny-inline-diagnostic").setup({
	preset = "modern",

	options = {
		show_source = false,
		multilines = false,
		multiple_diag_under_cursor = true,
		use_icons_from_diagnostic = true,
	},
})
