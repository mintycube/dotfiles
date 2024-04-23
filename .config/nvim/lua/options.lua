-- indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- search and replace
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.gdefault = true
vim.opt.showmatch = true
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.inccommand = "nosplit"

-- user interface
vim.opt.fillchars = { eob = " " }
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.conceallevel = 2
vim.opt.list = false
-- vim.opt.listchars = {eol = "󰌑" }
vim.opt.showmode = false
-- vim.opt.colorcolumn = "80"
vim.opt.winminwidth = 5

-- editing
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.autowrite = true
vim.opt.mouse = "a"
vim.opt.whichwrap:append("<>,[,],h,l")
vim.opt.iskeyword:append("-")

-- window management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- auto change dir
vim.opt.autochdir = true

-- fold options
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.shortmess = "aoOFCWstTAIcCqFS"

-- gui options
vim.opt.guifont = "JetBrainsMono NF:h9"

-- neovide ui
vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10
