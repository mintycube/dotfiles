local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.signatureHelpProvider = false
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})
lspconfig.marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "markdown" },
})
lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "yaml" },
})
-- lspconfig.grammarly.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "markdown" },
-- }
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sh" },
})
lspconfig.asm_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "asm" },
})
