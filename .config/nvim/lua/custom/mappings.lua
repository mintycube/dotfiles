local M = {}

M.general = {

	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-Left>"] = { ":vertical resize -2<CR>", "window down", opts = { silent = true } },
		["<C-Right>"] = { ":vertical resize +2<CR>", "window up", opts = { silent = true } },
		["<C-Up>"] = { ":resize +2<CR>", "window left", opts = { silent = true } },
		["<C-Down>"] = { ":resize -2<CR>", "window right", opts = { silent = true } },
		["J"] = { "mzJ`z", "the line below is appended to the current line", opts = {} },
		["<C-d>"] = { "<C-d>zz", "Half pade down", opts = {} },
		["<C-u>"] = { "<C-u>zz", "Half page up", opts = {} },
		["n"] = { "nzzzv", "Search forward", opts = {} },
		["N"] = { "Nzzzv", "Search backward", opts = {} },
		["<leader>x"] = { "<cmd>!chmod +x %<CR>", "chmod+x", opts = {} },
		["k"] = { "v:count == 0 ? 'gk' : 'k'", opts = { expr = true, silent = true } },
		["j"] = { "v:count == 0 ? 'gj' : 'j'", opts = { expr = true, silent = true } },
		["<leader>s"] = { ":%s/<C-r><C-w>//gI<Left><Left><Left>", opts = {} },
		["<a-j>"] = { ":m .+1<cr>==", opts = {} },
		["<a-k>"] = { ":m .-2<cr>==", opts = {} },
		["/"] = { "/\\v", opts = {} },
		["<leader>a"] = { "<cmd>%yank<CR>", opts = {} },
		["<A-;>"] = { "<Esc>miA;<Esc>`i", opts = {} },
		["<A-r>"] = { ":lua RUN_CODE()<CR>", opts = { silent = true } },
		["<A-z>"] = { ":ZenMode<CR>", opts = { silent = true } },
	},

	x = {
		["j"] = { ":m '>+1<cr>gv=gv", opts = {} },
		["k"] = { ":m '<-2<cr>gv=gv", opts = {} },
		["<a-j>"] = { ":m '>+1<cr>gv=gv", opts = {} },
		["<a-k>"] = { ":m '<-2<cr>gv=gv", opts = {} },
	},

	v = {
		["<"] = { "<gv^", opts = {} },
		[">"] = { ">gv^", opts = {} },
		["<a-j>"] = { ":m '>+1<cr>gv=gv", opts = {} },
		["<a-k>"] = { ":m '<-2<cr>gv=gv", opts = {} },
	},

	i = {
		["<c-u>"] = { "<Esc>viwUea", opts = {} },
		["<c-t>"] = { "<Esc>b~lea", opts = {} },
		["<A-;>"] = { "<Esc>miA;<Esc>`ii", opts = {} },
	},
}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add a breakpoint at line",
		},
		["<leader>dr"] = {
			"<cmd> DapContinue <CR>",
			"Start or Continue debugger",
		},
	},
}

M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
		},
		"Start pyhton debugger",
	},
}

M.symbols_outline = {
	plugin = true,
	n = {
		["<leader>o"] = {
			":SymbolsOutline<CR>",
			"Toggle Symbols Sidebar",
			opts = { silent = true },
		},
	},
}

M.nvterm = {
	n = {
		["<leader>md"] = {
			function()
				require("nvterm.terminal").send("clear && glow -s auto " .. vim.fn.expand("%") .. "", "vertical")
			end,
			"Render Markdown",
		},
	},
}

return M
