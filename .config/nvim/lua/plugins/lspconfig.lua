-- Load and configure LSP and diagnostic signs: nvim-lspconfig , mason.nvim, mason-lspconfig
return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPost", "BufNewFile" },
	ft = { "sh", "python", "cpp", "c", "lua", "markdown" },
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					-- C++
					"clangd",
					"clang-format",
					-- python
					"pyright",
					"black",
					"ruff",
					-- markdown
					"marksman",
					"markdownlint",
					-- html, css, javascript
					"prettier",
					-- lua
					"stylua",
					--sh
					"bashls",
					"shfmt",
					"shellcheck",
				},
			},
		},
		"williamboman/mason-lspconfig.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "folke/neodev.nvim",
	},

	opts = {
		-- options for vim.diagnostic.config()
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
			float = {
				source = "always",
			},
		},
	},
	config = function()
		local signs = { Error = " ", Warn = " ", Hint = "󰌵", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		local _border = "single"

		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		-- vim.lsp.handlers.hover, {
		--   border = _border
		-- }
		-- )
		--
		-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		-- vim.lsp.handlers.signature_help, {
		--   border = _border
		-- }
		-- )

		vim.diagnostic.config({
			float = { border = _border },
		})

		local on_attach = function(_, bufnr)
			local bufmap = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr })
			end
			bufmap("<leader>r", vim.lsp.buf.rename, "LSP [R]ename")
			bufmap("K", vim.lsp.buf.hover)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		require("mason").setup()
		require("mason-lspconfig").setup_handlers({

			function(server_name)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				-- require("neodev").setup()
				require("lspconfig").lua_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				})
			end,

			["clangd"] = function()
				require("lspconfig").clangd.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			["bashls"] = function()
				require("lspconfig").bashls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			["pyright"] = function()
				require("lspconfig").pyright.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			["marksman"] = function()
				require("lspconfig").marksman.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
