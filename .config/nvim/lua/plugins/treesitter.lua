-- Load and configure: nvim-treesitter , nvim-treesitter-context
return
{
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    ensure_installed = {
      "bash",
      "html",
      "css",
      "javascript",
      "lua",
      "python",
      "vim",
      "vimdoc",
      "yaml",
      "json",
      "c",
      "cpp",
      "go",
      "rust",
      "regex",
      "markdown",
      "markdown_inline",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  },
}
