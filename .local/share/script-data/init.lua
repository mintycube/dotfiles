-- colorscheme
vim.cmd.colorscheme("default")
vim.opt.background = "light"

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
vim.opt.laststatus = 0
vim.opt.number = false
vim.opt.ruler = false
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.list = false
vim.opt.showmode = false
-- vim.opt.colorcolumn = "80"
vim.opt.winminwidth = 5

-- editing
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.updatetime = 250
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

-- fold options
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.shortmess = "aoOFCWstTAIcCqF"

vim.opt.virtualedit = "block"
vim.opt.smoothscroll = true
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.showcmd = false

vim.keymap.set("n", "q", "<cmd>q!<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>q!<CR>")
