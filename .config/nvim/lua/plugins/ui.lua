return {
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "Outline" },
        on_colors = function(colors)
          colors.bg = "#16161E"
          colors.bg_dark = "#0d0d12"
        end,
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
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- icons
  {
    "nvim-tree/nvim-web-devicons",
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local lualine = require("lualine")
      local themecolor = require("tokyonight.colors").setup()
      local colors = {
        bg = "#0d0d12",
        fg = themecolor.fg_dark,
        yellow = themecolor.yellow,
        cyan = themecolor.cyan,
        green = themecolor.green,
        magenta = themecolor.magenta,
        blue = themecolor.blue,
        red = themecolor.red,
        low = themecolor.terminal_black,
        mode = themecolor.terminal_black,
        bg2 = "#292e42",
        bg3 = "#16161e"
      }
      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.magenta,
        ["^V"] = colors.magenta,
        V = colors.magenta,
        c = colors.blue,
        no = colors.red,
        ic = colors.yellow,
        R = colors.red,
        Rv = colors.red,
        cv = colors.red,
        ce = colors.red,
        r = colors.blue,
        rm = colors.blue,
        ["r?"] = colors.blue,
        ["!"] = colors.blue,
        t = colors.blue,
      }
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          disabled_filetypes = { "help", "lazy", "mason", "fzf", "lspinfo", "alpha" },
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg3 } },
            inactive = { c = { fg = colors.fg, bg = colors.bg3 } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end
      ins_left({
        function()
          return ""
        end,
        color = { fg = colors.bg2, bg = colors.bg3 },
        padding = { left = 0, right = 0 },
      })
      ins_left({
        function()
          return " "
          -- return " "
          -- return " "
        end,
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.bg2 }
        end,
        padding = { left = 0, right = 0 },
      })
      ins_left({
        function()
          return ""
        end,
        color = { fg = colors.bg2 },
        padding = { left = 0, right = 1 },
      })
      ins_left({
        "buffers",
        buffers_color = {
          active = { fg = colors.magenta, bg = colors.bg3 },
          inactive = { fg = colors.low, bg = colors.bg3 },
        },
        symbols = {
          modified = " ●",
          alternate_file = "",
        },
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = "bold" },
      })
      ins_right({
        function()
          if vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" or vim.bo.filetype == "tex" then
            if vim.fn.wordcount().visual_words == 1 then
              return tostring(vim.fn.wordcount().visual_words) .. " word"
            elseif not (vim.fn.wordcount().visual_words == nil) then
              return tostring(vim.fn.wordcount().visual_words) .. " words"
            else
              return tostring(vim.fn.wordcount().words) .. " words"
            end
          else
            return ""
          end
        end,
        color = { fg = colors.low },
      })
      ins_right({
        -- Lsp server name
        function()
          local msg = "Inactive"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " ",
        color = { fg = colors.low },
      })
      ins_right({
        "branch",
        icon = "",
        color = { fg = colors.low, gui = "bold" },
      })
      ins_right({
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.low },
          modified = { fg = colors.low },
          removed = { fg = colors.low },
        },
        cond = conditions.hide_in_width,
      })
      ins_right({
        "location",
        color = function()
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { left = 0, right = 1 },
      })
      ins_right({
        function()
          return ""
        end,
        color = { fg = colors.bg2 },
        padding = { left = 0, right = 0 },
      })
      ins_right({
        "progress",
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.bg2, gui = "bold" }
        end,
        padding = { left = 0, right = 0 },
      })
      ins_right({
        function()
          return ""
        end,
        color = { fg = colors.bg2, bg = colors.bg3 },
        padding = { left = 0, right = 0 },
      })
      lualine.setup(config)
    end,
  },

  -- indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      -- scope = { enabled = false },
      scope = { enabled = true },
      exclude = {
        filetypes = { "help", "lazy", "mason", "outline", "toggleterm", "fzf", "lspinfo" },
      },
    },
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require("alpha.themes.dashboard")

      local create_gradient = function(start, finish, steps)
        local r1, g1, b1 =
            tonumber("0x" .. start:sub(2, 3)),
            tonumber("0x" .. start:sub(4, 5)),
            tonumber("0x" .. start:sub(6, 7))
        local r2, g2, b2 =
            tonumber("0x" .. finish:sub(2, 3)),
            tonumber("0x" .. finish:sub(4, 5)),
            tonumber("0x" .. finish:sub(6, 7))

        local r_step = (r2 - r1) / steps
        local g_step = (g2 - g1) / steps
        local b_step = (b2 - b1) / steps

        local gradient = {}
        for i = 1, steps do
          local r = math.floor(r1 + r_step * i)
          local g = math.floor(g1 + g_step * i)
          local b = math.floor(b1 + b_step * i)
          table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
        end

        return gradient
      end

      local function apply_gradient_hl(text)
        local gradient = create_gradient("#7aa2f7", "#414868", #text)

        local lines = {}
        for i, line in ipairs(text) do
          local tbl = {
            type = "text",
            val = line,
            opts = {
              hl = "HeaderGradient" .. i,
              shrink_margin = false,
              position = "center",
            },
          }
          table.insert(lines, tbl)

          -- create hl group
          vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = gradient[i] })
        end

        return {
          type = "group",
          val = lines,
          opts = { position = "center" },
        }
      end

      local headers = require("ascii")

      dashboard.section.buttons.val = {
        dashboard.button("r", "  Recent files", ":lua require('fzf-lua').oldfiles()<CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "  Projects",
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
          end),

        dashboard.button("f", "  Find file", ":lua require('fzf-lua').files()<CR>"),
        dashboard.button("t", "󱎸  Find text", ":lua require('fzf-lua').live_grep_native()<CR>"),
        dashboard.button("s", "  Restore Session", ":lua require('persistence').load()<CR>"),
        dashboard.button("n", "󰠮  Notes", ":lua require('fzf-lua').files({cwd =[[~/notes]]})<CR>"),
        dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("z", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      dashboard.section.buttons.opts.spacing = 0

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "󱎫  " .. ms .. " ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      local headerKeys = {}
      for key, _ in pairs(headers) do
        table.insert(headerKeys, key)
      end
      local randomHeader = headerKeys[math.random(#headerKeys)]

      dashboard.config.layout = {
        { type = "padding", val = 3 },
        -- options = randomHeader, raven, yggdrasil,
        -- void_stranger, aot, meatboy, isaac, gta,
        -- hydra, spider, morse, sharp, galaxy,
        apply_gradient_hl(headers[randomHeader]),
        { type = "padding", val = 4 },
        dashboard.section.buttons,
        { type = "padding", val = 4 },
        dashboard.section.footer,
      }

      dashboard.opts.opts.noautocmd = true
      require("alpha").setup(dashboard.opts)
    end,
  },

  -- zen-mode
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0,
        width = 100,
        height = 0.85,
      },
      plugins = {
        gitsigns = { enabled = false },
        kitty = {
          enabled = true,
          font = "+2",
        },
      },
    },
    keys = {
      { "<leader>z", ":lua require('zen-mode').toggle()<CR>", desc = "[Z]en Mode", silent = true },
    },
  },
}
