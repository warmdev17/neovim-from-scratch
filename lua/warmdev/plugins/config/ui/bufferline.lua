require("bufferline").setup({
	options = {
		always_show_bufferline = false,
		separator_style = "slope", -- "slant", "slope", "thin"
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
