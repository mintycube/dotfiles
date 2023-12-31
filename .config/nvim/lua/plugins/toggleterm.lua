-- Load and configure: toggleterm.nvim
return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>t", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Open terminal" },
		{ "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Toggle Lazy[G]it", silent = true, noremap = true, },
		{ "<leader>p", ":lua RUN_CODE()<CR>", desc = "Run [P]roject", silent = true, noremap = true, },
	},
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.45
				end
			end,
		})
		local run_command_table = {
			["cpp"] = "([[ -f Makefile ]] && make run) || (cd .. && make all run)",
			["c"] = "gcc -g -Wall % -o %:r && ./%:r",
			["python"] = "python %",
			["lua"] = "lua %",
			["zsh"] = "zsh %",
			["sh"] = "sh %",
			-- ["java"] = "cd %:h && javac *.java && java %:t:r",
			-- ["asm"] = "nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r && ./%:r && rm %:r.o",
			-- ["cpp"] = "g++ -g -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -std=c++20 -pedantic-errors % -o %:r && ./%:r",
			-- ["rust"] = "rustc % && ./%:r",
			-- ["go"] = "go run %",
			-- ["javascript"] = "node %",
		}

		local extra = 'printf "\\\\n\\\\033[0;33mPress ENTER to continue \\\\033[0m"; read'
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

		function RUN_CODE()
			if run_command_table[vim.bo.filetype] then
				local expanded_cmd = EXPAND_SYMBOL_RESOLVER(run_command_table[vim.bo.filetype])
				local runcmd = expanded_cmd .. "; " .. extra
				local runterm = Terminal:new({ cmd = runcmd, direction = "vertical" })
				runterm:toggle()
			else
				print("\nFileType not supported\n")
			end
		end

		function _LAZYGIT_TOGGLE()
			Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" }):toggle()
		end
	end,
}
