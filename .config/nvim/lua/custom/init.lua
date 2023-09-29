require("custom.options")
require("custom.autocmds")

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
	vim.keymap.set("i", ch, ch .. "<c-g>u")
end
