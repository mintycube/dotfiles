return {
	"lervag/vimtex",
	ft = "tex",
	dependencies = {
		{
			"iurimateus/luasnip-latex-snippets.nvim",
			dependencies = "L3MON4D3/LuaSnip",
			config = function()
				require("luasnip-latex-snippets").setup()
				-- or setup({ use_treesitter = true })
				require("luasnip").config.setup({ enable_autosnippets = true })
			end,
		},
	},
  keys = {
    { "<leader>cc", "<cmd>VimtexCompile<cr>", desc = "[C]ompile latex" },
    { "<leader>co", "<cmd>VimtexCompileOutput<cr>", desc = "Show latex compiler output" },
  },
	config = function()
		vim.g.vimtex_view_general_viewer = "zathura"
		-- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
		-- vim.g.vimtex_quickfix_enabled = 1
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_method = 'tectonic'
		-- vim.cmd("call vimtex#init()")
	end,
}
