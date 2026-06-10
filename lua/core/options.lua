local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.statuscolumn = " %=%{v:relnum?v:relnum:v:lnum} %s"
opt.signcolumn = "yes"

opt.fillchars:append({ eob = " " })
opt.cursorline = true
opt.showmode = false

opt.clipboard = "unnamedplus"

opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 10

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.undolevels = 10000
opt.undoreload = 10000

opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.equalalways = false

opt.timeoutlen = 300
opt.updatetime = 200

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autoread = true

opt.cmdheight = 1
opt.laststatus = 3
opt.pumheight = 10
opt.completeopt = { "menu", "menuone", "noselect" }

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.hidden = true
opt.confirm = true
opt.shortmess:append("c")
opt.whichwrap:append("<>[]hl")

opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

opt.diffopt:append({
	"algorithm:histogram",
	"indent-heuristic",
})

opt.virtualedit = "block"

vim.diagnostic.config({
	virtual_text = false,
})
