return {
  'ibhagwan/fzf-lua',
  keys = {
    { "<leader>/",   function() require("fzf-lua").buffers() end,                   desc = "Switch buffers" },
    { "<leader>l",   function() require("fzf-lua").live_grep_native() end,          desc = "Live Grep" },
    { "<leader>f",   function() require("fzf-lua").files() end,                     desc = "Open file" },
    { "<leader>o",   function() require("fzf-lua").oldfiles() end,                  desc = "Open Recent file" },
    { "<leader>b",   function() require("fzf-lua").builtin() end,                   desc = "FZF menu" },
    { "<leader>ca",  function() require("fzf-lua").lsp_code_actions() end,          desc = "LSP Code Actions" },
    { "<leader>cd",  function() require("fzf-lua").lsp_definitions() end,           desc = "LSP Definitions" },
    { "<leader>cD",  function() require("fzf-lua").lsp_declarations() end,          desc = "LSP Declarations" },
    { "<leader>cI",  function() require("fzf-lua").lsp_implementations() end,       desc = "LSP Implementations" },
    { "<leader>cr",  function() require("fzf-lua").lsp_references() end,            desc = "LSP References" },
    { "<leader>ce",  function() require("fzf-lua").lsp_document_diagnostics() end,  desc = "LSP Diagnostics" },
    { "<leader>cwe", function() require("fzf-lua").lsp_workspace_diagnostics() end, desc = "LSP Workspace Diagnostics" },
    {"<leader>cm",   function() require('fzf-lua').files({cwd = "~", cmd="fzflua-mfiles"}) end,desc=  "Important files" },
  },
  opts = {
    previewers = {
      builtin = {
        extensions = {
          -- neovim terminal only supports `viu` block output
          ["png"] = { "ueberzug" },
          ["jpg"] = { "ueberzug" },
        },
        -- When using 'ueberzug' we can also control the way images
        -- fill the preview area with ueberzug's image scaler, set to:
        --   false (no scaling), "crop", "distort", "fit_contain",
        --   "contain", "forced_cover", "cover"
        -- For more details see:
        -- https://github.com/seebye/ueberzug
        ueberzug_scaler = "cover",
      }
    }
  }
}
