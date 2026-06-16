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
	"spider",
}

for _, module in ipairs(editorModules) do
	require("warmdev.plugins.config.editor." .. module)
end
