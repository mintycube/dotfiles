local options = {
	-- indentation
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	smartindent = true,
	breakindent = true,
	autoindent = true,
	smarttab = true,

	-- search and replace
	ignorecase = true,
	smartcase = true,
	hlsearch = false,
	incsearch = true,
	gdefault = true,
	showmatch = true,

	-- user interface
	fillchars = { eob = " " },
	laststatus = 3,
	number = true,
	numberwidth = 2,
	relativenumber = false,
	ruler = false,
	wrap = true,
	termguicolors = true,
	scrolloff = 8,
	sidescrolloff = 8,
	signcolumn = "yes",
	cursorline = true,
	cursorlineopt = "both",
	conceallevel = 3,
	list = true,
	showmode = false,

	-- editing
	completeopt = { "menuone", "noselect" },
	timeoutlen = 300,
	undofile = true,

	-- window management
	splitbelow = true,
	splitright = true,
	mouse = "a",
	winblend = 0,

	-- clipboard
	clipboard = "unnamedplus",
	pumblend = 10,

	--auto change dir
	autochdir = true,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.opt.shortmess:append("sI")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")

-- -- ui modern
vim.opt.cmdheight = 0
vim.g.VM_set_statusline = 0
vim.g.VM_silent_exit = 1
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.pumheight = 10

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono NF:h10"
	vim.opt.linespace = 0
	vim.g.neovide_scale_factor = 1.0
	-- vim.g.neovide_floating_blur_amount_x = 2.0
	-- vim.g.neovide_floating_blur_amount_y = 2.0
	-- vim.g.neovide_transparency = 0.8
	-- vim.g.neovide_hide_mouse_when_typing = false
	-- vim.g.neovide_refresh_rate = 60
	-- vim.g.neovide_refresh_rate_idle = 5
end
