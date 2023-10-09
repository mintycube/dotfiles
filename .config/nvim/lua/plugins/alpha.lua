return {
	"goolord/alpha-nvim",
	lazy = false,
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		local create_gradient = function(start, finish, steps)
			local r1, g1, b1 =
				tonumber("0x" .. start:sub(2, 3)), tonumber("0x" .. start:sub(4, 5)), tonumber("0x" .. start:sub(6, 7))
			local r2, g2, b2 =
				tonumber("0x" .. finish:sub(2, 3)),
				tonumber("0x" .. finish:sub(4, 5)),
				tonumber("0x" .. finish:sub(6, 7))

			local r_step = (r2 - r1) / steps
			local g_step = (g2 - g1) / steps
			local b_step = (b2 - b1) / steps

			local gradient = {}
			for i = 1, steps do
				local r = math.floor(r1 + r_step * i)
				local g = math.floor(g1 + g_step * i)
				local b = math.floor(b1 + b_step * i)
				table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
			end

			return gradient
		end

		local function apply_gradient_hl(text)
			local gradient = create_gradient("#a2b9c6", "#719eee", #text)

			local lines = {}
			for i, line in ipairs(text) do
				local tbl = {
					type = "text",
					val = line,
					opts = {
						hl = "HeaderGradient" .. i,
						shrink_margin = false,
						position = "center",
					},
				}
				table.insert(lines, tbl)

				-- create hl group
				vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = gradient[i] })
			end

			return {
				type = "group",
				val = lines,
				opts = { position = "center" },
			}
		end

		local aot_header = {
			[[⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⡄⠀⠀]],
			[[⢰⠒⠒⢻⣿⣶⡒⠒⠒⠒⠒⠒⠒⠒⠒⠒⡲⠊⣰⣓⡒⡆]],
			[[⢸⢸⢻⣭⡙⢿⣿⣍⡉⠉⡇⡏⠉⠉⣩⠋⢀⣔⠕⢫⡇⡇]],
			[[⢸⢸⣈⡻⣿⣶⣽⡸⣿⣦⡇⡇⡠⠊⣸⢶⠋⢁⡤⠧⡇⡇]],
			[[⢸⢸⠻⣿⣶⣝⠛⣿⣮⢻⠟⣏⣠⠞⠁⣼⡶⠋⢀⣴⡇⡇]],
			[[⢸⢸⣿⣶⣍⠻⠼⣮⡕⢁⡤⢿⢁⡴⠊⣸⣵⠞⠋⢠⡇⡇]],
			[[⢸⢘⣛⡻⣿⣧⢳⣿⣧⠎⢀⣾⠋⡠⠞⢱⢇⣠⡴⠟⡇⡇]],
			[[⢸⢸⠹⣿⣷⣎⣉⣻⢁⡔⢁⢿⡏⢀⣤⢾⡟⠁⣀⣎⡇⡇]],
			[[⢸⢸⠲⣶⣭⡛⠚⢿⢋⡔⢁⣼⠟⢋⣠⣼⠖⠋⢁⠎⡇⡇]],
			[[⢸⢸⢤⣬⣛⠿⠞⣿⢋⠔⣉⣾⠖⠋⢁⣯⡴⠞⢃⠂⡇⡇]],
			[[⢸⢸⠀⢙⣻⢿⣧⣾⡵⠚⣉⣯⠶⠛⣹⣧⠤⢮⠁⠀⡇⡇]],
			[[⠸⣘⠢⣄⠙⠿⢷⡡⠖⣋⣽⠥⠒⣩⣟⣤⣔⣁⡤⠖⣃⠇]],
			[[⠀⠀⠙⠢⢍⣻⡿⠒⢉⣴⣗⣚⣽⣋⣀⣤⣊⠥⠒⠉⠀⠀]],
			[[⠀⠀⠀⢀⣔⠥⠒⢮⣙⠾⠀⠷⣚⡭⠞⠉⠛⠦⣀⠀⠀⠀]],
			[[⠀⠀⠀⠉⠀⠀⠀⠀⠈⠑⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("r", "  Recent files", ":lua require('fzf-lua').oldfiles()<CR>"),
			dashboard.button("i", "󰈙  Important files", ":lua require('fzf-lua').files({cwd =[[~]], cmd=[[fzflua-mfiles]]})<CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  Find file", ":lua require('fzf-lua').files()<CR>"),
			dashboard.button("t", "󱎸  Find text", ":lua require('fzf-lua').live_grep_native()<CR>"),
			dashboard.button("n", "󰠮  Notes", ":lua require('fzf-lua').files({cwd =[[~/notes]]})<CR>"),
			dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
			dashboard.button("z", "󰒲  Lazy", ":Lazy<CR>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}
		dashboard.section.buttons.opts.spacing = 0

		local function footer()
			return os.date("%A %B %d")
		end

    dashboard.section.footer.val = footer()

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.config.layout = {
			{ type = "padding", val = 3 },
			apply_gradient_hl(aot_header),
			{ type = "padding", val = 4 },
			dashboard.section.buttons,
			{ type = "padding", val = 4 },
			dashboard.section.footer,
		}

		dashboard.opts.opts.noautocmd = true
		require("alpha").setup(dashboard.opts)
	end,
}
