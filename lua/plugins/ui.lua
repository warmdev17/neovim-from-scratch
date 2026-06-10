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

local icons = require("config.icons")
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		refresh = {
			statusline = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icon_only = true,
				fmt = function(str)
					local m = vim.api.nvim_get_mode().mode

					local icons = {
						n = "",
						i = "",
						v = "󰈈",
						V = "󰈈",
						["\22"] = "󰈈",
						c = "",
						R = "󰑖",
						t = "",
					}

					local names = {
						n = "N",
						i = "I",
						v = "V",
						V = "V-L",
						["\22"] = "V-B",
						c = "C",
						R = "R",
						t = "T",
					}

					return (icons[m] or "") .. " " .. (names[m] or str)
				end,
			},
		},

		lualine_b = {
			"branch",
		},

		lualine_c = {
			"filename",
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
		},

		lualine_x = {
			{
				"diff",
				symbols = {
					added = icons.git.added,
					modified = icons.git.modified,
					removed = icons.git.removed,
				},
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
			},
			"fileformat",
			{
				"filetype",
				icon_only = true,
			},
		},

		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("vim._core.ui2").enable()

require("bufferline").setup({
	options = {
		always_show_bufferline = false,
		separator_style = "slant", -- "slant", "slope", "thin"
		show_buffer_close_icons = false,
		show_close_icon = false,
		diagnostics = "nvim_lsp",

		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or (level:match("warning") and " " or " ")
			return " " .. icon .. count
		end,

		offsets = {
			{
				filetype = "snacks_picker_list",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
	},
})

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

local wk = require("which-key")

wk.add({
	{ "<leader>f", group = "find" },
	{ "<leader>g", group = "git" },
	{ "<leader>c", group = "code" },
	{ "<leader>l", group = "lint/format" },
	{ "<leader>r", group = "rest" },
	{ "<leader>d", group = "debug/database" },
	{ "<leader>t", group = "terminal/test" },
})

wk.setup({
	preset = "modern",
	delay = 300,

	win = {
		border = "single",
		padding = { 1, 2 },
		title = true,
		title_pos = "center",

		row = -1,
		col = math.huge,

		width = { min = 35, max = 50 },
		height = { min = 4, max = 14 },

		no_overlap = false,
	},

	layout = {
		width = { min = 20, max = 30 },
		spacing = 3,
	},

	icons = {
		mappings = false,
		group = "+",
		separator = "➜",
	},
})
