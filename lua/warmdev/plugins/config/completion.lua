local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = "none",

		["<Tab>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },

		["<C-e>"] = { "cancel", "fallback" },

		["<A-l>"] = { "snippet_forward" },
		["<A-h>"] = { "snippet_backward" },

		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},

	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},

		menu = {
			draw = {
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon

							if ctx.item.source_name == "LSP" then
								local colorItem = require("nvim-highlight-colors").format(ctx.item.documentation, {
									kind = ctx.kind,
								})

								if colorItem and colorItem.abbr ~= "" then
									icon = colorItem.abbr
								end
							end

							return icon .. ctx.icon_gap
						end,

						highlight = function(ctx)
							local highlight = "BlinkCmpKind" .. ctx.kind

							if ctx.item.source_name == "LSP" then
								local colorItem = require("nvim-highlight-colors").format(ctx.item.documentation, {
									kind = ctx.kind,
								})

								if colorItem and colorItem.abbr_hl_group then
									highlight = colorItem.abbr_hl_group
								end
							end

							return highlight
						end,
					},
				},
			},
		},
	},

	cmdline = {
		keymap = {
			preset = "cmdline",
			["<Tab>"] = { "accept" },
			["<CR>"] = { "fallback" },
			["<Right>"] = false,
			["<Left>"] = false,
		},
		completion = {
			list = { selection = { preselect = true } },
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
			ghost_text = { enabled = true },
		},
	},
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("Comment").setup({
	pre_hook = function(ctx)
		return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
	end,
})

require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
})

require("inc_rename").setup({
	input_buffer_type = "snacks",
})

local map = vim.keymap.set
local incRenamePrefix = "IncRename "

local function isIncRenameCmdline()
	local cmdType = vim.fn.getcmdtype()
	local cmdLine = vim.fn.getcmdline()

	return cmdType == ":" and vim.startswith(cmdLine, incRenamePrefix)
end

local function isAtIncRenamePrefix()
	local cmdLine = vim.fn.getcmdline()
	local cmdPos = vim.fn.getcmdpos()

	return isIncRenameCmdline() and #cmdLine <= #incRenamePrefix and cmdPos <= #incRenamePrefix + 1
end

map("c", "<BS>", function()
	if isAtIncRenamePrefix() then
		return ""
	end

	return "<BS>"
end, { expr = true, desc = "Protected backspace for IncRename" })

map("c", "<C-w>", function()
	if isAtIncRenamePrefix() then
		return ""
	end

	return "<C-w>"
end, { expr = true, desc = "Protected delete word for IncRename" })

map("c", "<C-u>", function()
	if isIncRenameCmdline() then
		return incRenamePrefix
	end

	return "<C-u>"
end, { expr = true, desc = "Protected clear line for IncRename" })

map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, {
	expr = true,
	desc = "Rename",
})
require("luasnip.loaders.from_vscode").lazy_load()
