return {
  "nvimtools/none-ls.nvim",
  event = "LspAttach",
  -- ft = { "cpp", "lua", "python", "markdown", "sh" },
  -- event = "VeryLazy",
  opts = function()
    local formatting = require("null-ls").builtins.formatting
    local lint = require("null-ls").builtins.diagnostics
    -- local actions = require("null-ls").builtins.code_actions
    return {
      sources = {
        -- C++
        formatting.clang_format,
        lint.cppcheck, -- must install manually using pacman
        -- python
        formatting.black,
        lint.ruff,
        -- actions.refactoring,
        -- markdown
        formatting.prettier,
        -- sh
        lint.shellcheck,
        -- actions.shellcheck,
        formatting.shfmt,
        -- lua
        formatting.stylua,
      },
    }
  end,
  keys = {
    { "<leader>cf", ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>", desc = "Format", silent = true },
  },
}
