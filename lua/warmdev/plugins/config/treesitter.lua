require("nvim-treesitter").install({
	"rust",
	"javascript",
	"typescript",
	"tsx",
	"python",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"zig",
	"c",
	"cpp",
	"c_sharp",
	"java",
	"scala",
	"kotlin",
	"ruby",
	"php",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"html",
	"css",
	"scss",
	"json",
	"yaml",
	"toml",
	"xml",
	"graphql",
	"sql",
	"bash",
	"fish",
	"dockerfile",
	"regex",
	"make",
	"cmake",
	"vue",
	"svelte",
	"astro",
	"solidity",
})

require("treesitter-context").setup({
	max_lines = 3,
})

local textobjects = require("nvim-treesitter-textobjects")
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

textobjects.setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v",
			["@function.outer"] = "V",
			["@class.outer"] = "V",
		},
		include_surrounding_whitespace = false,
	},

	move = {
		set_jumps = true,
	},
})

local function mapSelect(lhs, capture, desc)
	vim.keymap.set({ "x", "o" }, lhs, function()
		select.select_textobject(capture, "textobjects")
	end, { desc = desc })
end

local function mapMove(nextKey, prevKey, capture, desc)
	vim.keymap.set({ "n", "x", "o" }, nextKey, function()
		move.goto_next_start(capture, "textobjects")
	end, { desc = "Next " .. desc })

	vim.keymap.set({ "n", "x", "o" }, prevKey, function()
		move.goto_previous_start(capture, "textobjects")
	end, { desc = "Previous " .. desc })
end

mapSelect("af", "@function.outer", "Around Function")
mapSelect("if", "@function.inner", "Inside Function")

mapSelect("ac", "@class.outer", "Around Class")
mapSelect("ic", "@class.inner", "Inside Class")

mapSelect("al", "@loop.outer", "Around Loop")
mapSelect("il", "@loop.inner", "Inside Loop")

mapSelect("ai", "@conditional.outer", "Around Conditional")
mapSelect("ii", "@conditional.inner", "Inside Conditional")

mapSelect("aa", "@parameter.outer", "Around Argument")
mapSelect("ia", "@parameter.inner", "Inside Argument")

mapMove("]f", "[f", "@function.outer", "Function")
mapMove("]c", "[c", "@class.outer", "Class")
mapMove("]l", "[l", "@loop.outer", "Loop")
mapMove("]i", "[i", "@conditional.outer", "Conditional")
mapMove("]a", "[a", "@parameter.inner", "Argument")

vim.keymap.set("n", "<leader>sa", function()
	swap.swap_next("@parameter.inner")
end, { desc = "Swap Argument Next" })

vim.keymap.set("n", "<leader>sA", function()
	swap.swap_previous("@parameter.inner")
end, { desc = "Swap Argument Previous" })
