local configModules = {
	"options",
	"autocmds",
	"keymaps",
	"commands",
}

for _, module in ipairs(configModules) do
	require("warmdev.config." .. module)
end

require("warmdev.plugins")
