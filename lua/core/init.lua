local coreModules = {
	"options",
	"keymaps",
	"autocmd",
	"packs",
}

for _, module in ipairs(coreModules) do
	require("core." .. module)
end
