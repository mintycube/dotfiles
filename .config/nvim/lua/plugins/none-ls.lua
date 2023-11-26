-- Load and configure linting and formatting: none-ls.nvim
return {
  "nvimtools/none-ls.nvim",
  event = "LspAttach",
  opts = function()
    local formatting = require("null-ls").builtins.formatting
    local lint = require("null-ls").builtins.diagnostics
    -- local actions = require("null-ls").builtins.code_actions
    return {
      sources = {
        -- C++
        formatting.clang_format,
        lint.cppcheck, -- install manually using pacman
        -- python
        formatting.black,
        lint.ruff,
        -- markdown
        formatting.markdownlint,
        lint.markdownlint,
        lint.proselint,
        -- sh
        lint.shellcheck,
        -- actions.shellcheck,
        formatting.shfmt,
        -- lua
        formatting.stylua,
        -- latex
        formatting.latexindent,
      },
    }
  end,
  keys = {
    { "<leader>cf", ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>", desc = "Format", silent = true },
  },
}
