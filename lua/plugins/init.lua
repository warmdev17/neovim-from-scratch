local pluginModules = {
	"ui",
	"editor",
	"tools",
	"treesitter",
	"mason",
	"lsp",
}

for _, module in ipairs(pluginModules) do
	require("plugins." .. module)
end
