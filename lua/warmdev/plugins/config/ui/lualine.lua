local icons = require("warmdev.config.icons")
local venv = require("venv-selector.statusline.lualine")
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "│", right = "│" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		refresh = {
			statusline = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					local m = vim.api.nvim_get_mode().mode

					local names = {
						n = "N",
						i = "I",
						v = "V",
						V = "V-L",
						["\22"] = "V-B",
						c = "C",
						R = "R",
						t = "T",

						no = "O-P",
					}
					return names[m] or names[m] or "N"
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
			venv.render,
		},

		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
