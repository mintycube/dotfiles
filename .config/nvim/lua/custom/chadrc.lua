---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "tokyodark",
	hl_override = {
		CursorLine = { bg = "#181925" },
		Comment = { italic = true },
		Conditional = { bold = true, italic = true },
		Keyword = { italic = true },
		MatchParen = { bold = true },
		String = { italic = true },
		Type = { bold = true },
	},
	statusline = {
		theme = "vscode",
	},
	tabufline = {
		overriden_modules = function(modules)
			modules[4] = (function()
				return ""
			end)()
		end,
	},
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
