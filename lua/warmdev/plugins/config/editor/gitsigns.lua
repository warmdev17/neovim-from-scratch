require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				silent = true,
				desc = desc,
			})
		end

		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
				return
			end

			gitsigns.nav_hunk("next")
		end, "Next Hunk")

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
				return
			end

			gitsigns.nav_hunk("prev")
		end, "Previous Hunk")

		map("n", "<leader>gh", gitsigns.preview_hunk, "Preview Hunk")
		map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Hunk")
		map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Hunk")

		map("v", "<leader>gs", function()
			gitsigns.stage_hunk({
				vim.fn.line("."),
				vim.fn.line("v"),
			})
		end, "Stage Selected Hunk")

		map("v", "<leader>gr", function()
			gitsigns.reset_hunk({
				vim.fn.line("."),
				vim.fn.line("v"),
			})
		end, "Reset Selected Hunk")

		map("n", "<leader>gH", function()
			gitsigns.setqflist("all")
			vim.cmd("copen")
		end, "Git Hunks Quickfix")

		map("n", "<leader>gb", function()
			gitsigns.blame_line({ full = true })
		end, "Git Blame Line")

		map("n", "<leader>gd", gitsigns.diffthis, "Git Diff This")

		map("n", "<leader>gD", function()
			gitsigns.diffthis("~")
		end, "Git Diff This ~")

		map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle Git Blame")
	end,
})

local map = vim.keymap.set

map("n", "<leader>gb", function()
	require("gitsigns").blame_line()
end, { desc = "Git blame line" })

map("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Git preview hunk" })

map("n", "<leader>gr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Git reset hunk" })
