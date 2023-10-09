vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	defaults = { lazy = true },
	spec = {
		require("plugins.ui"),
		require("plugins.treesitter"),
		require("plugins.lspconfig"),
		require("plugins.none-ls"),
		require("plugins.completion"),
		require("plugins.fzf"),
		require("plugins.toggleterm"),
		require("plugins.utils"),
		require("plugins.alpha"),
	},
	ui = { border = "rounded" },
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
				"matchparen",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
			}
		}
	}
})

require("autocommands")
require("mappings")
