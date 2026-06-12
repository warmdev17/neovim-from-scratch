require("gx").setup({
	open_browser_app = "xdg-open",
})

vim.keymap.set({ "n", "x" }, "gx", "<cmd>Browse<cr>", {
	silent = true,
	desc = "Open Link",
})
