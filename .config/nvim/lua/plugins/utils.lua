-- Load and configure: Comment , nvim-surround , nvim-autopairs , lightspeed , nvim-colorizer , lf.nvim , indent-blankline , zen-mode.nvim , git-signs
return {
	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
		},
	},

	{
		"numToStr/Comment.nvim",
		opts = {},
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<space>", " ", "'", "`", "g", "c", "v" },
		cmd = "WhichKey",
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			ignored_next_char = "[%w%.]",
		},
	},

	{
		"ggandor/leap.nvim",
		dependencies = { "ggandor/flit.nvim", "tpope/vim-repeat" },
		event = "VeryLazy",
		config = function()
			require("leap").add_default_mappings()
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
			vim.api.nvim_set_hl(0, "LeapMatch", {
				fg = "white",
				bold = true,
				nocombine = true,
			})
			vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
				fg = "#f02077",
				bold = true,
				nocombine = true,
			})
			vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
				fg = "#99ddff",
				bold = true,
				nocombine = true,
			})
			require("leap").opts.highlight_unlabeled_phase_one_targets = true
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = {
			user_default_options = {
				css = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				names = false,
				RGB = false,
			},
		},
	},

	{
		"lmburns/lf.nvim",
		cmd = "Lf",
		dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
		opts = {
			winblend = 0,
			highlights = { NormalFloat = { guibg = "NONE" } },
			border = "single",
			escape_quit = true,
		},
		keys = {
			{ "<leader><space>", "<cmd>Lf<cr>", desc = "Lf file manager" },
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.7",
		event = "VeryLazy",
		-- event = { "BufRead" },
		opts = {
			filetype_exclude = { "help", "lazy", "mason", "outline", "toggleterm", "fzf", "lspinfo" },
			show_trailing_blankline_indent = false,
			show_current_context = true,
			show_current_context_start = false,
		},
	},

	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				backdrop = 1,
				width = 100,
				height = 0.85,
			},
			plugins = {
				gitsigns = { enabled = false },
				kitty = {
					enabled = true,
					font = "+2",
				},
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>hp",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "Preview git hunk" }
				)
				local gs = package.loaded.gitsigns
				vim.keymap.set({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},
}
