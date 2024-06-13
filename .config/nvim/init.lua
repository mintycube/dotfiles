vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.colorscheme("default")
-- vim.opt.background = "light"

require("options")
require("manager")
require("autocommands")
require("mappings")

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
