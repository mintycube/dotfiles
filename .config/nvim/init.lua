vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("manager")
require("autocommands")
require("mappings")

-- vim.cmd("hi Keyword gui=italic,bold cterm=italic,bold")
vim.cmd("hi Comment gui=italic cterm=italic")
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
