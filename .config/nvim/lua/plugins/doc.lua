return {
  -- markdown
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    -- opts = {
    --   headings = {
    --     enable = true,
    --     shift_width = 4,
    --     heading_1 = {
    --       style = "label",
    --     },
    --     heading_2 = {
    --       style = "label",
    --     },
    --     heading_3 = {
    --       style = "label",
    --     },
    --     heading_4 = {
    --       style = "label",
    --     },
    --     heading_5 = {
    --       style = "label",
    --     },
    --     heading_6 = {
    --       style = "label",
    --     }
    --   }
    -- }
  },
  {
    "ixru/nvim-markdown",
    ft = { "markdown" },
  },

  -- glow preview
  {
    "0x00-ketsu/markdown-preview.nvim",
    keys = {
      { "<leader>cm", "<cmd>lua require('markdown-preview')<cr><cmd>MPToggle<cr>", desc = "[M]arkdown preview" },
    },
    opts = {},
  },

  -- qalc
  -- {
  --   "iffse/qalculate.vim",
  --   event = "BufEnter *.qalc",
  -- },
  {
    "grueslayer/qalc.nvim",
    branch = "scratch_buffer",
    event = "BufEnter *.qalc",
    cmd = { "QalcAttach", "QalcYank" },
    dependencies = {
      "iffse/qalculate.vim"
    },
    keys = {
      { "<leader>cqa", "<cmd>QalcAttach<CR>", desc = "Attach Calculator" },
      { "<leader>cqy", "<cmd>QalcYank<CR>",   desc = "Yank Result" },
    },
    opts = {
      cmd_args = { 't' },          -- table
      bufname = '',                -- string
      set_ft = 'qalculate',        -- string
      attach_extension = '*.qalc', -- string
      sign = ' ==> ',              -- string
      show_sign = true,            -- boolean
      right_align = true,          -- boolean
      highlights = {
        sign   = '@comment',       -- sign before result
        result = '@string',        -- result in virtual text
      },
      diagnostics = {              -- table
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
      }
    }
  },

  -- vimtex + snippets
  {
    "lervag/vimtex",
    ft = "tex",
    dependencies = {
      {
        "iurimateus/luasnip-latex-snippets.nvim",
        dependencies = "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip-latex-snippets").setup()
          -- or setup({ use_treesitter = true })
          require("luasnip").config.setup({ enable_autosnippets = true })
        end,
      },
    },
    keys = {
      { "<leader>cc", "<cmd>VimtexCompile<cr>",       desc = "[C]ompile latex" },
      { "<leader>co", "<cmd>VimtexCompileOutput<cr>", desc = "Show latex compiler output" },
    },
    config = function()
      vim.g.vimtex_view_general_viewer = "zathura"
      -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      -- vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_method = "tectonic"
      -- vim.cmd("call vimtex#init()")
    end,
  }
}
