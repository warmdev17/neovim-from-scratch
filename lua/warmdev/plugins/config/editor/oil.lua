local function countNormalWindows()
	local count = 0

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local config = vim.api.nvim_win_get_config(win)

		if config.relative == "" then
			count = count + 1
		end
	end

	return count
end

require("oil").setup({
	default_file_explorer = true,
	watch_for_changes = true,
	columns = {
		"icon",
	},
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["q"] = function()
			if countNormalWindows() > 1 then
				vim.cmd("close")
			else
				vim.cmd("quitall")
			end
		end,
		["<C-t>"] = false,
	},
})

require("oil-git").setup()

local map = vim.keymap.set
map("n", "<leader>e", function()
	require("oil").open()
end, { desc = "Open Oil" })
