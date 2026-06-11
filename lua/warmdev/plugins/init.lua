local spec_modules = {
	"ui",
	"editor",
	"git",
	"lsp",
	"completion",
	"treesitter",
	"tools",
}

local all_specs = {}

for _, module in ipairs(spec_modules) do
	local specs = require("warmdev.plugins.specs." .. module)
	for _, spec in ipairs(specs) do
		table.insert(all_specs, spec)
	end
end

vim.pack.add(all_specs)

local config_modules = {
	"ui",
	"editor",
	"lsp",
	"completion",
	"treesitter",
	"format",
	"tools",
}

for _, module in ipairs(config_modules) do
	require("warmdev.plugins.config." .. module)
end
