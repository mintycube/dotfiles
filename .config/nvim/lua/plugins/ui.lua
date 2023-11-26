-- Load and configure: oxocarbon.nvim , noice.nvim + nui.nvim , lualine.nvim
return {
	-- Load tokyodark as colorscheme
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("oxocarbon")
			local hl = vim.api.nvim_set_hl
			hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
			hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
			hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
			hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
			hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#858694" })
			hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#858694" })
			hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#858694" })
			hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#858694" })
		end,
	},

	-- experimental ui
	-- {
	-- 	"folke/noice.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim" },
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true,
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			command_palette = true, -- position the cmdline and popupmenu together
	-- 			lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- },

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local lualine = require("lualine")
			local colors = {
				bg = "#161616",
				fg = "#dde1e6",
				yellow = "#ffab91",
				cyan = "#08bdba",
				green = "#42be65",
				violet = "#be95ff",
				blue = "#78a9ff",
				red = "#ee5396",
				low = "#37474f",
			}
			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}
			local config = {
				options = {
					component_separators = "",
					section_separators = "",
					disabled_filetypes = { "help", "lazy", "mason", "toggleterm", "fzf", "lspinfo", "alpha" },
					theme = {
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end
			ins_left({
				function()
					return " 󰣠"
				end,
				color = function()
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						["^V"] = colors.blue,
						V = colors.blue,
						c = colors.violet,
						no = colors.red,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})
			ins_left({
				"buffers",
				filetype_names = {
					fzf = "fzf",
					alpha = "Alpha",
					toggleterm = "Terminal",
				},
				buffers_color = {
					-- Same values as the general color option can be used here.
					active = { fg = colors.violet, bg = colors.bg }, -- Color for active buffer.
					inactive = { fg = colors.low, bg = colors.bg }, -- Color for inactive buffer.
				},
				symbols = {
					modified = " ●", -- Text to show when the buffer is modified
					alternate_file = "", -- Text to show to identify the alternate file
				},
				cond = conditions.buffer_not_empty,
				color = { fg = colors.violet, gui = "bold" },
			})
			ins_right({
				"branch",
				icon = "",
				color = { fg = colors.low, gui = "bold" },
			})
			ins_right({
				"diff",
				symbols = { added = " ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = colors.low },
					modified = { fg = colors.low },
					removed = { fg = colors.low },
				},
				cond = conditions.hide_in_width,
			})
			ins_right({ "location" })
			ins_right({ "progress", color = { fg = colors.fg, gui = "bold" } })
			lualine.setup(config)
		end,
	},
}
