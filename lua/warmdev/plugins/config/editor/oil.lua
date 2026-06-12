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
	skip_confirm_for_simple_edits = true,
	delete_to_trash = true,
	columns = {
		"icon",
	},
	view_options = {
		show_hidden = true,
		natural_order = true,
		is_always_hidden = function(name, _)
			return name == ".." or name == ".git"
		end,
	},
	win_options = {
		wrap = true,
	},
	keymaps = {
		["q"] = function()
			if countNormalWindows() > 1 then
				vim.cmd("close")
			else
				vim.cmd("quitall")
			end
		end,
		["d"] = {
			callback = function()
				vim.cmd.normal({ "dd", bang = true })
			end,
			desc = "Delete Entry",
		},
		["w"] = {
			callback = function()
				require("oil").save()
			end,
			desc = "Save Oil Changes",
		},
		["<A-k>"] = "actions.parent",
		["r"] = "actions.refresh",
		["<C-t>"] = false,
	},
})

require("oil-git").setup()

local map = vim.keymap.set
map("n", "<leader>e", function()
	require("oil").open()
end, { desc = "Open Oil" })
