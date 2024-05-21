return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-buffer" },
      { "https://codeberg.org/FelipeLema/cmp-async-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "rafamadriz/friendly-snippets" },
      { "onsails/lspkind.nvim" },
      { "hrsh7th/cmp-calc" },
      { "f3fora/cmp-spell" },
      { "micangl/cmp-vimtex" },
      { "Jezda1337/nvim-html-css" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      -- Lazy load snippets from VSCode
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/snippets" } })

      cmp.setup({
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "async_path" },
          { name = "calc" },
          { name = "html-css" },
          { name = "vimtex" },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
            },
          },
        },
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          maxwidth = 30,
          fields = { "abbr", "kind" },
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 30,
            ellipsis_char = "",
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      })
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          -- exclude = { 'gl', 'K' },
        })
      end)

      vim.diagnostic.config({
        underline = false,
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "󰌵",
            [vim.diagnostic.severity.INFO]  = ""
          }
        },
        update_in_insert = false,
        severity_sort = true,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "ruff_lsp",
          "marksman",
          "html",
          "cssls",
          "lua_ls",
          "bashls",
          "texlab",
          "jsonls",
          "eslint",
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false },
                },
                completion = {
                  callSnippet = 'Replace',
                },
              },
            })
          end,
          clangd = function()
            require("lspconfig").clangd.setup({
              capabilities = { offsetEncoding = "utf-16" },
              -- cmd = {
              --   "clangd",
              --   "--background-index",
              --   "--clang-tidy",
              --   "--header-insertion=iwyu",
              --   "--completion-style=detailed",
              --   "--function-arg-placeholders",
              --   "--fallback-style=llvm",
              -- },
              -- init_options = {
              --   usePlaceholders = true,
              --   completeUnimported = true,
              --   clangdFileStatus = true,
              -- },
            })
          end,
          -- ltex = function()
          -- 	require("lspconfig").ltex.setup({
          -- 		settings = {
          -- 			ltex = {
          --              language = {"en-US"},
          --              -- dictionary = {":~/.config/nvim/spell/en.utf-8.add"},
          --              disabledRules = { ['en-US'] = { 'MORFOLOGIK_RULE_EN_US' } },
          -- 			},
          -- 		},
          -- 	})
          -- end,
        },
      })
    end,
  },
}
