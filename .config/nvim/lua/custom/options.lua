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
	number = true,
	relativenumber = true,
	wrap = true,
	termguicolors = true,
	scrolloff = 8,
	sidescrolloff = 8,
	signcolumn = "yes",
	cursorline = true,
	cursorlineopt = "both",
	list = true,
	showmode = false,
	-- editing
	completeopt = { "menuone", "noselect" },

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

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
