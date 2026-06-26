require("venv-selector").setup({
	filetype = "python",
	vim.keymap.set("n", "<leader>.", "<cmd>VenvSelect<cr>", { silent = true, noremap = true }),
})
