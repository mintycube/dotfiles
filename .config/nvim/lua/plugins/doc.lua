return {
  -- markdown
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
  {
    "Apeiros-46B/qalc.nvim",
    event = "BufEnter *.qalc",
    cmd = { "QalcAttach", "QalcYank" },
    keys = {
      { "<leader>cqa", "<cmd>QalcAttach<CR>", desc = "Attach Calculator" },
      { "<leader>cqy", "<cmd>QalcYank<CR>",   desc = "Yank Result" },
    },
    opts = {
      cmd_args = {},               -- table
      bufname = '',                -- string
      set_ft = 'config',           -- string
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
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    enabled = false,
    dependencies = { "luarocks.nvim" },
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
