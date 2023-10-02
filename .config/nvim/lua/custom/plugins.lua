local plugins = {
	{
		"folke/neodev.nvim",
		opts = {
			library = {
				plugins = {
					"nvim-dap-ui",
				},
				types = true,
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		lazy = false,
		opts = {
			window = {
				backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 100, -- width of the Zen window
				height = 0.85, -- height of the Zen window
				-- by default, no options are changed for the Zen window
				-- uncomment any of the options below, or add other vim.wo options you want to apply
				options = {
					-- signcolumn = "no", -- disable signcolumn
					-- number = false, -- disable number column
					-- relativenumber = false, -- disable relative numbers
					-- cursorline = false, -- disable cursorline
					-- cursorcolumn = false, -- disable cursor column
					-- foldcolumn = "0", -- disable fold column
					-- list = false, -- disable whitespace characters
				},
			},
			plugins = {
				-- disable some global vim options (vim.o...)
				-- comment the lines to not apply the options
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
				},
				twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false }, -- disables git signs
				tmux = { enabled = false }, -- disables the tmux statusline
				-- this will change the font size on kitty when in zen mode
				-- to make this work, you need to set the following kitty options:
				-- - allow_remote_control socket-only
				-- - listen_on unix:/tmp/kitty
				kitty = {
					enabled = true,
					font = "+2", -- font size increment
				},
				-- this will change the font size on alacritty when in zen mode
				-- requires  Alacritty Version 0.10.0 or higher
				-- uses `alacritty msg` subcommand to change font size
				alacritty = {
					enabled = false,
					font = "14", -- font size
				},
				-- this will change the font size on wezterm when in zen mode
				-- See alse also the Plugins/Wezterm section in this projects README
				wezterm = {
					enabled = false,
					-- can be either an absolute font size or the number of incremental steps
					font = "+4", -- (10% increase per step)
				},
			},
			-- callback where you can add custom code when the Zen window opens
			-- on_open = function(win) end,
			-- callback where you can add custom code when the Zen window closes
			-- on_close = function() end,
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				--asm
				"asm_lsp",
				"asmfmt",
				-- C++
				"clangd",
				"clang-format",
				"codelldb",
				-- python
				"pyright",
				"black",
				"ruff",
				"debugpy",
				-- markdown
				"marksman",
				"markdownlint",
				-- html, css, javascript
				"prettierd",
				-- lua
				"stylua",
				--sh
				"bashls",
				"shfmt",
				"shellcheck",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		ft = { "c", "cpp", "pyhton", "markdown", "sh", "lua" },
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		ft = { "cpp", "c", "lua", "python", "markdown", "html", "css", "javascript", "sh" },
		-- event = "VeryLazy",
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		ft = { "python", "cpp", "c" },
		config = function(_, _)
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
		config = function(_, _)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("core.utils").load_mappings("dap_python")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		-- ft = { "python", "cpp", "c", "lua", "sh", "html", "json", "go", "rust" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("treesitter-context").setup()
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		ft = { "pyhton", "cpp", "c" },
		-- event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
		opts = {
			handlers = {},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		ft = { "python", "cpp", "c" },
		-- event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_existed["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"vimwiki/vimwiki",
		lazy = false,
		init = function()
			vim.g.vimwiki_list = { { path = "~/vimwiki", syntax = "markdown", ext = ".md" } }
			vim.g.vimwiki_filetypes = { "markdown" }
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		ft = {
			"bash",
			"html",
			"css",
			"javascript",
			"lua",
			"python",
			"vim",
			"vimdoc",
			"yaml",
			"json",
			"c",
			"cpp",
			"go",
			"rust",
			"regex",
			"markdown",
			"markdown_inline",
			"org",
		},
		opts = {
			hightlight = { enable = true },
			ensure_installed = {
				"bash",
				"html",
				"css",
				"javascript",
				"lua",
				"python",
				"vim",
				"vimdoc",
				"yaml",
				"json",
				"c",
				"cpp",
				"go",
				"rust",
				"regex",
				"markdown",
				"markdown_inline",
			},
		},
		{ "ggandor/lightspeed.nvim", dependencies = { "tpope/vim-repeat" }, event = "VeryLazy" },
		{
			"simrat39/symbols-outline.nvim",
			ft = { "c", "cpp", "python", "lua", "sh", "markdown", "html", "css", "javascript" },
			config = function()
				require("symbols-outline").setup({
					highlight_hovered_item = true,
					show_guides = true,
					auto_preview = false,
					position = "right",
					relative_width = true,
					width = 25,
					auto_close = true,
					show_numbers = false,
					show_relative_numbers = false,
					show_symbol_details = true,
					preview_bg_highlight = "Pmenu",
					autofold_depth = nil,
					auto_unfold_hover = true,
					fold_markers = { "", "" },
					wrap = false,
					keymaps = { -- These keymaps can be a string or a table for multiple keys
						close = { "<Esc>", "q" },
						goto_location = "<Cr>",
						focus_location = "o",
						hover_symbol = "<C-space>",
						toggle_preview = "K",
						rename_symbol = "r",
						code_actions = "a",
						fold = "h",
						unfold = "l",
						fold_all = "W",
						unfold_all = "E",
						fold_reset = "R",
					},
					lsp_blacklist = {},
					symbol_blacklist = {},
					symbols = {
						File = { icon = "󰈔", hl = "@text.uri" },
						Module = { icon = "󰆧", hl = "@namespace" },
						Namespace = { icon = "", hl = "@namespace" },
						Package = { icon = "", hl = "@namespace" },
						Class = { icon = "", hl = "@type" },
						Method = { icon = "", hl = "@method" },
						Property = { icon = "", hl = "@method" },
						Field = { icon = "", hl = "@field" },
						Constructor = { icon = "", hl = "@constructor" },
						Enum = { icon = "", hl = "@type" },
						Interface = { icon = "", hl = "@type" },
						Function = { icon = "󰊕", hl = "@function" },
						Variable = { icon = "", hl = "@constant" },
						Constant = { icon = "", hl = "@constant" },
						String = { icon = "", hl = "@string" },
						Number = { icon = "", hl = "@number" },
						Boolean = { icon = "", hl = "@boolean" },
						Array = { icon = "", hl = "@constant" },
						Object = { icon = "", hl = "@type" },
						Key = { icon = "", hl = "@type" },
						Null = { icon = "NULL", hl = "@type" },
						EnumMember = { icon = "", hl = "@field" },
						Struct = { icon = "", hl = "@type" },
						Event = { icon = "", hl = "@type" },
						Operator = { icon = "+", hl = "@operator" },
						TypeParameter = { icon = "󰬁", hl = "@parameter" },
						Component = { icon = "󰅴", hl = "@function" },
						Fragment = { icon = "󰅴", hl = "@constant" },
					},
				})
				require("core.utils").load_mappings("symbols_outline")
			end,
		},
		{
			"NvChad/nvim-colorizer.lua",
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
			"nvim-tree/nvim-tree.lua",
			enabled = false,
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			event = "VeryLazy",
			config = function()
				require("toggleterm").setup()
				-- refer this wiki to know how to use path specifiers in vim
				-- https://vim.fandom.com/wiki/Get_the_name_of_the_current_file

				local run_command_table = {
					["asm"] = "nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r && ./%:r && rm %:r.o",
					-- ["cpp"] = "g++ -g -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -std=c++20 -pedantic-errors % -o %:r && ./%:r",
					["cpp"] = "cd .. && make run",
					["c"] = "gcc -g -Wall % -o %:r && ./%:r",
					["python"] = "python %",
					["lua"] = "lua %",
					["java"] = "cd %:h && javac *.java && java %:t:r",
					["zsh"] = "zsh %",
					["sh"] = "sh %",
					["rust"] = "rustc % && ./%:r",
					["go"] = "go run %",
					["javascript"] = "node %",
				}

				-- local debug_command_table = {
				--   ["cpp"] = "g++ -g % -o %:r && gdb ./%:r",
				--   ["c"] = "gcc -g % -o %:r && gdb ./%:r",
				-- }

				local extra = 'printf "\\\\n\\\\033[0;33mPlease Press ENTER to continue \\\\033[0m"; read'
				local Terminal = require("toggleterm.terminal").Terminal

				function EXPAND_SYMBOL_RESOLVER(cmd)
					local mod = string.byte("%")
					local space = string.byte(" ")
					local col = string.byte(":")
					local i = 1
					local expanded_cmd = ""
					while i <= #cmd do
						if cmd:byte(i) == mod then
							local j = i + 1
							while cmd:byte(j) == col and cmd:byte(j + 1) ~= space and j <= #cmd do
								j = j + 2
							end
							expanded_cmd = expanded_cmd .. vim.fn.expand(string.sub(cmd, i, j - 1))
							i = j
						end
						expanded_cmd = expanded_cmd .. string.sub(cmd, i, i)
						i = i + 1
					end

					return expanded_cmd
				end

				-- To run file run :Run or just press <F5>
				function RUN_CODE()
					if run_command_table[vim.bo.filetype] then
						local expanded_cmd = EXPAND_SYMBOL_RESOLVER(run_command_table[vim.bo.filetype])
						local runcmd = expanded_cmd .. "; " .. extra
						local runterm = Terminal:new({ cmd = runcmd, direction = "float" })
						runterm:toggle()
					else
						print("\nFileType not supported\n")
					end
				end

				-- -- To run file run :Debug
				-- function debug_code()
				--   if debug_command_table[vim.bo.filetype] then
				--     local expanded_cmd = expand_symbol_resolver(debug_command_table[vim.bo.filetype])
				--     local runcmd = expanded_cmd .. "; " .. extra
				--     local debugterm = Terminal:new({ cmd = runcmd, direction = "float" })
				--     debugterm:toggle()
				--   else
				--     print("\nFileType not supported\n")
				--   end
				-- end

				-- local function strsplit(inputstr)
				--   local t = {}
				--   for str in string.gmatch(inputstr, '([^","]+)') do
				--     table.insert(t, str)
				--   end
				--   return t
				-- end
				--
				-- Use the following function to update the execution command of a filetype temporarly
				-- Usage :RunUpdate  --OR-- :RunUpdate filetype
				-- If no argument is provided, the command is going to take the filetype of active buffer
				-- function update_command_table(type, filetype)
				--   local command
				--
				--   if filetype == "" then
				--     filetype = vim.bo.filetype
				--   else
				--     filetype = string.sub(filetype, 2, -2)
				--   end
				--
				--   filetype = strsplit(filetype)[1]
				--
				--   if type == "run" then
				--     if run_command_table[filetype] then
				--       command = vim.fn.input(
				--         string.format("Update run command of filetype (%s): ", filetype),
				--         run_command_table[filetype],
				--         "file"
				--       )
				--     else
				--       command = vim.fn.input(string.format("Add new run command of filetype (%s): ", filetype))
				--     end
				--     if #command ~= 0 then
				--       run_command_table[filetype] = command
				--       print("  Updated!")
				--     end
				--   end
				--
				--   if type == "debug" then
				--     if debug_command_table[filetype] then
				--       command = vim.fn.input(
				--         string.format("Update debug command of filetype (%s): ", filetype),
				--         debug_command_table[filetype],
				--         "file"
				--       )
				--     else
				--       command = vim.fn.input(string.format("Add new debug command of filetype (%s): ", filetype))
				--     end
				--     if #command ~= 0 then
				--       debug_command_table[filetype] = command
				--       print("  Updated!")
				--     end
				--   end
				-- end
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			ft = { "c", "cpp", "python", "lua", "sh", "markdown", "html", "css", "javascript" },
			event = { "BufReadPost", "BufNewFile" },
			opts = {
				filetype_exclude = { "help", "lazy", "mason", "outline" },
				show_trailing_blankline_indent = false,
				show_current_context = true,
				show_current_context_start = false,
			},
		},
	},
}
return plugins
