local uiModules = {
	"theme",
	"lualine",
	"bufferline",
	"snacks",
	"which-key",
	"colorizer",
	"indent",
	"dropbar",
}

for _, module in ipairs(uiModules) do
	require("warmdev.plugins.config.ui." .. module)
end

require("vim._core.ui2").enable()
require("colorful-menu").setup({})
