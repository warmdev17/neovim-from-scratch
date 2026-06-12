local editorModules = {
	"oil",
	"gitsigns",
	"tmux",
	"flash",
	"mini",
	"silicon",
	"babel",
	"markview",
	"gx",
}

for _, module in ipairs(editorModules) do
	require("warmdev.plugins.config.editor." .. module)
end
