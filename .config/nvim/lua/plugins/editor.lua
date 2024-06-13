return {
  -- project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<A-p>",
        function()
          local contents = require("project_nvim").get_recent_projects()
          local reverse = {}
          for i = #contents, 1, -1 do
            reverse[#reverse + 1] = contents[i]
          end
          require("fzf-lua").fzf_exec(reverse, {
            actions = {
              ["default"] = function(e)
                -- vim.cmd.cd(e[1])
                require("fzf-lua").files({ cwd = e[1] })
              end,
              ["ctrl-d"] = function(x)
                local choice = vim.fn.confirm("Delete '" .. #x .. "' projects? ", "&Yes\n&No", 2)
                if choice == 1 then
                  local history = require("project_nvim.utils.history")
                  for _, v in ipairs(x) do
                    history.delete_project(v)
                  end
                end
              end,
            },
            winopts = {
              height = 0.3,
              width = 0.5,
            },
          })
        end,
        desc = "Projects"
      },
    },
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "tex" },
      }
    end,
  },

  -- harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end,                                    desc = "Add to list" },
      { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "harpoon ui" },
      { "<leader>1", function() require("harpoon"):list():select(1) end,                                desc = "Harpoon Select 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end,                                desc = "Harpoon Select 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end,                                desc = "Harpoon Select 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end,                                desc = "Harpoon Select 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end,                                desc = "Harpoon Select 5" },
      { "<leader>6", function() require("harpoon"):list():select(6) end,                                desc = "Harpoon Select 6" },
      { "<leader>7", function() require("harpoon"):list():select(7) end,                                desc = "Harpoon Select 7" },
      { "<leader>8", function() require("harpoon"):list():select(8) end,                                desc = "Harpoon Select 8" },
      { "<leader>9", function() require("harpoon"):list():select(9) end,                                desc = "Harpoon Select 9" },
    },
    config = function()
      require("harpoon"):setup()
    end
  },

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble" },
    event = "VeryLazy",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      -- { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      -- { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },

  -- trouble
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>xS", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references/definitions/... (Trouble)", },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  -- spectre
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
  },

  -- sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },

  -- illuminate
  {
    "RRethy/vim-illuminate",
    enabled = false,
    event = "VeryLazy",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      filetypes_denylist = {
        "alpha",
        "help",
        "lazy",
        "mason",
        "outline",
        "toggleterm",
        "fzf",
        "lspinfo",
        "null-ls-info",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- symbols sidebar
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>cn", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      outline_window = {
        focus_on_open = false,
      },
    },
  },

  -- folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {},
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
  },

  -- surround
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { "<leader>", "<space>", " ", "'", "`", "g", "c", "v", "z", "[", "]", "<M>" },
    cmd = "WhichKey",
    opts = {},
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      ignored_next_char = "[%w%.]",
    },
  },

  -- leap
  {
    "ggandor/leap.nvim",
    enabled = true,
    dependencies = {
      {
        "ggandor/flit.nvim",
        enabled = true,
        keys = function()
          local ret = {}
          for _, key in ipairs({ "f", "F", "t", "T" }) do
            ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
          end
          return ret
        end,
        opts = { labeled_modes = "nx" },
      },
      { "tpope/vim-repeat" },
    },
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
      vim.api.nvim_set_hl(0, "LeapMatch", { fg = "white", bold = true, nocombine = true })
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#f02077", bold = true, nocombine = true })
      vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#99ddff", bold = true, nocombine = true })

      local api = vim.api
      local ts = vim.treesitter

      local function get_ts_nodes()
        if not pcall(ts.get_parser) then return end
        local wininfo = vim.fn.getwininfo(api.nvim_get_current_win())[1]
        -- Get current node, and then its parent nodes recursively.
        local cur_node = ts.get_node()
        if not cur_node then return end
        local nodes = { cur_node }
        local parent = cur_node:parent()
        while parent do
          table.insert(nodes, parent)
          parent = parent:parent()
        end
        -- Create Leap targets from TS nodes.
        local targets = {}
        local startline, startcol
        for _, node in ipairs(nodes) do
          startline, startcol, endline, endcol = node:range() -- (0,0)
          local startpos = { startline + 1, startcol + 1 }
          local endpos = { endline + 1, endcol + 1 }
          -- Add both ends of the node.
          if startline + 1 >= wininfo.topline then
            table.insert(targets, { pos = startpos, altpos = endpos })
          end
          if endline + 1 <= wininfo.botline then
            table.insert(targets, { pos = endpos, altpos = startpos })
          end
        end
        if #targets >= 1 then return targets end
      end

      local function select_node_range(target)
        local mode = api.nvim_get_mode().mode
        -- Force going back to Normal from Visual mode.
        if not mode:match('no?') then vim.cmd('normal! ' .. mode) end
        vim.fn.cursor(unpack(target.pos))
        local v = mode:match('V') and 'V' or mode:match('�') and '�' or 'v'
        vim.cmd('normal! ' .. v)
        vim.fn.cursor(unpack(target.altpos))
      end

      local function leap_ts()
        require('leap').leap {
          target_windows = { api.nvim_get_current_win() },
          targets = get_ts_nodes,
          action = select_node_range,
        }
      end

      vim.keymap.set({ 'x', 'o' }, '\\', leap_ts)
    end,
  },

  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      user_default_options = {
        css = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        names = false,
        RGB = false,
      },
    },
  },

  -- file manager
  {
    "lmburns/lf.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
    opts = {
      winblend = 0,
      highlights = { NormalFloat = { guibg = "NONE" } },
      border = "rounded",
      escape_quit = true,
    },
    keys = {
      { "<leader><space>", "<cmd>lua require('lf').start()<cr>", desc = "Lf file manager" },
    },
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(function()
              require("lazy").load({ plugins = { "gitsigns.nvim" } })
            end)
          end
        end,
      })
    end,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- undotree sidebar
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    opts = {},
    keys = {
      { "<leader>t", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Open terminal" },
      {
        "<leader>gg",
        "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
        desc = "Toggle Lazy[G]it",
        silent = true,
        noremap = true,
      },
      {
        "<leader>p",
        ":lua RUN_CODE()<CR>",
        desc = "Run [P]roject",
        silent = true,
        noremap = true,
      },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.45
          end
        end,
      })
      local run_command_table = {
        ["cpp"] = "([[ -f Makefile ]] && make all run)",
        ["c"] = "gcc -g -Wall % -o %:r && ./%:r",
        ["python"] = "python %",
        ["lua"] = "lua %",
        ["zsh"] = "zsh %",
        ["sh"] = "sh %",
        -- ["java"] = "cd %:h && javac *.java && java %:t:r",
        -- ["asm"] = "nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r && ./%:r && rm %:r.o",
        -- ["cpp"] = "g++ -g -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -std=c++20 -pedantic-errors % -o %:r && ./%:r",
        -- ["rust"] = "rustc % && ./%:r",
        -- ["go"] = "go run %",
        -- ["javascript"] = "node %",
      }

      local extra = 'printf "\\\\n\\\\033[0;33mPress ENTER to continue \\\\033[0m"; read'
      local Terminal = require("toggleterm.terminal").Terminal

      function EXPAND_SYMBOL_RESOLVER(cmd)
        local mod = string.byte("%")
        local space = string.byte(" ")
        local col = string.byte(":")
        local i = 1
        local expanded_cmd = ""
        while i <= #cmd do
          if cmd:byte(i) == mod then
            local j = i + 1
            while cmd:byte(j) == col and cmd:byte(j + 1) ~= space and j <= #cmd do
              j = j + 2
            end
            expanded_cmd = expanded_cmd .. vim.fn.expand(string.sub(cmd, i, j - 1))
            i = j
          end
          expanded_cmd = expanded_cmd .. string.sub(cmd, i, i)
          i = i + 1
        end

        return expanded_cmd
      end

      function RUN_CODE()
        if run_command_table[vim.bo.filetype] then
          local expanded_cmd = EXPAND_SYMBOL_RESOLVER(run_command_table[vim.bo.filetype])
          local runcmd = expanded_cmd .. "; " .. extra
          local runterm = Terminal:new({ cmd = runcmd, direction = "vertical" })
          runterm:toggle()
        else
          print("\nFileType not supported\n")
        end
      end

      function _LAZYGIT_TOGGLE()
        Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" }):toggle()
      end
    end,
  },
}
