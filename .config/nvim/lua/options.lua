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
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	inccommand = "nosplit", -- preview incremental substitute

	-- user interface
	fillchars = { eob = " " },
	laststatus = 3,
	number = true,
	numberwidth = 2,
	relativenumber = true,
	ruler = false,
	wrap = true,
	termguicolors = true,
	scrolloff = 4,
	sidescrolloff = 4,
	signcolumn = "yes",
	cursorline = true,
	cursorlineopt = "both",
	conceallevel = 3,
	list = true,
	showmode = false,
	colorcolumn = "80",
	winminwidth = 5,

	-- editing
	completeopt = { "menu", "menuone", "noselect" },
	timeoutlen = 300,
	undofile = true,
	autowrite = true,
	mouse = "a",

	-- window management
	splitbelow = true,
	splitright = true,

	-- clipboard
	clipboard = "unnamedplus",

	--auto change dir
	autochdir = true,

	--fold options
	foldlevel = 99,
	foldlevelstart = 99,
	foldenable = true,
	shortmess = "aowOFCWstTAIcCqFS",

	-- for neovim gui
	guifont = "JetBrainsMono NF:h9",

	-- modern ui
	winblend = 0,
	pumblend = 0,
	pumheight = 10,
  cmdheight = 0
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- modern ui
vim.g.VM_set_statusline = 0
vim.g.VM_silent_exit = 1
