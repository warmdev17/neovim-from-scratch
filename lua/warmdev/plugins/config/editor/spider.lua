local map = vim.keymap.set

require("spider").setup({
	skipInsignificantPunctuation = true,
	subwordMovement = true,
	consistentOperatorPending = false, -- see the README for details
	customPatterns = {}, -- see the README for details
})

map({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
map({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
map({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")
map({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>")
