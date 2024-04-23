return {
  -- fzf
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>/",   function() require("fzf-lua").buffers() end,                   desc = "Switch buffers" },
      { "<leader>l",   function() require("fzf-lua").live_grep_native() end,          desc = "Live Grep" },
      { "<leader>o",   function() require("fzf-lua").oldfiles() end,                  desc = "Open Recent file" },
      { "<leader>b",   function() require("fzf-lua").builtin() end,                   desc = "FZF menu" },
      { "<leader>ca",  function() require("fzf-lua").lsp_code_actions() end,          mode = { "n", "v" },               desc = "LSP Code Actions" },
      { "<leader>cd",  function() require("fzf-lua").lsp_definitions() end,           mode = { "n", "v" },               desc = "LSP Definitions" },
      { "<leader>cD",  function() require("fzf-lua").lsp_declarations() end,          mode = { "n", "v" },               desc = "LSP Declarations" },
      { "<leader>cI",  function() require("fzf-lua").lsp_implementations() end,       mode = { "n", "v" },               desc = "LSP Implementations" },
      { "<leader>cr",  function() require("fzf-lua").lsp_references() end,            mode = { "n", "v" },               desc = "LSP References" },
      { "<leader>ce",  function() require("fzf-lua").lsp_document_diagnostics() end,  desc = "LSP Diagnostics" },
      { "<leader>cwe", function() require("fzf-lua").lsp_workspace_diagnostics() end, desc = "LSP Workspace Diagnostics" },
      { "<leader>cD",  function() require("fzf-lua").lsp_declarations() end,          mode = { "n", "v" },               desc = "LSP Declarations" },
    },
    opts = {
      previewers = {
        builtin = {
          extensions = {
            ["png"] = { "ueberzug" },
            ["jpg"] = { "ueberzug" },
          },
          ueberzug_scaler = "cover",
        }
      }
    }
  }
}
