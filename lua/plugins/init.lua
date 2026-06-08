local pluginModules = {
	"editor",
	"lsp",
	"mason",
	"treesitter",
	"ui",
}

for _, module in ipairs(pluginModules) do
	require("plugins." .. module)
end
