return {  -- colorscheme
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --     })
  --     vim.cmd.colorscheme("catppuccin")
  --     local hl = vim.api.nvim_set_hl
  --     hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
  --   end
  -- },
  -- {
  --   'AlexvZyl/nordic.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require 'nordic'.load()
  --     -- vim.cmd.colorscheme("nordic")
  --     local hl = vim.api.nvim_set_hl
  --     hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
  --   end
  -- },
  -- {
  --   'comfysage/evergarden',
  --   priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  --   lazy = false,
  --   config = function()
  --     require("evergarden").setup({
  --       transparent_background = true,
  --       contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
  --     })
  --     -- vim.cmd.colorscheme("evergarden")
  --     local hl = vim.api.nvim_set_hl
  --     hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
  --   end
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "moon",
  --       dim_inactive_windows = true,
  --       groups = {
  --         error = "subtle",
  --         warn = "subtle",
  --         info = "subtle",
  --         hint = "subtle",
  --       }
  --     })
  --     -- vim.cmd.colorscheme("rose-pine")
  --   end
  -- },
  -- {
  --   "tiagovla/tokyodark.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("tokyodark").setup({
  --       transparent_background = false,                                        -- set background to transparent
  --       gamma = 1.00,                                                          -- adjust the brightness of the theme
  --       styles = {
  --         comments = { italic = true },                                        -- style for comments
  --         keywords = { italic = true },                                        -- style for keywords
  --         identifiers = { italic = true },                                     -- style for identifiers
  --         functions = {},                                                      -- style for functions
  --         variables = {},                                                      -- style for variables
  --       },
  --       custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
  --       custom_palette = {} or function(palette) return {} end,                -- extend palette
  --       terminal_colors = true,                                                -- enable terminal colors
  --     })
  --     -- vim.cmd.colorscheme("tokyodark")
  --   end,
  -- },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- vim.cmd.colorscheme("oxocarbon")
  --     local hl = vim.api.nvim_set_hl
  --     hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
  --     hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
  --     hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#858694" })
  --     hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#858694" })
  --     hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#858694" })
  --     hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#858694" })
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "Outline" },
        -- on_colors = function(colors)
        --   colors.bg = "#16161E"
        --   colors.bg_dark = "#0d0d12"
        -- end,
        on_highlights = function(hl, colors)
          hl.DiagnosticVirtualTextError = {
            fg = colors.comment
          }
          hl.DiagnosticVirtualTextHint = {
            fg = colors.comment
          }
          hl.DiagnosticVirtualTextInfo = {
            fg = colors.comment
          }
          hl.DiagnosticVirtualTextWarn = {
            fg = colors.comment
          }
          -- hl.DiagnosticSignError = {
          --   fg = colors.comment
          -- }
          -- hl.DiagnosticSignHint = {
          --   fg = colors.comment
          -- }
          -- hl.DiagnosticSignInfo = {
          --   fg = colors.comment
          -- }
          -- hl.DiagnosticSignWarn = {
          --   fg = colors.comment
          -- }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
