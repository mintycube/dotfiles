return {

-- formatting and linting
  {
    "nvimtools/none-ls.nvim",
    event = "LspAttach",
    opts = function()
      local formatting = require("null-ls").builtins.formatting
      local lint = require("null-ls").builtins.diagnostics
      local code_actions = require("null-ls").builtins.code_actions
      -- local actions = require("null-ls").builtins.code_actions
      return {
        sources = {
          -- Linting
          lint.cppcheck, -- for c,cpp ( Install manually using pacman )
          lint.proselint, -- for md
          lint.stylelint, -- for css
          lint.codespell, -- general code spellings

          -- Formatting
          formatting.shfmt, -- for sh
          formatting.prettier, -- for js, md, html, css``

          -- Code Actions
          code_actions.proselint,
          code_actions.gitsigns,
          code_actions.refactoring.with({
            filetypes = {
              "go",
              "javascript",
              "lua",
              "python",
              "typescript",
              "c",
              "cpp"
            }
          }),
        },
      }
    end,
    keys = {
      { "<leader>f", ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>", desc = "Format", silent = true },
    },
  }
}
