-- [[ Highlight on yank ]]
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- [[ Disable Autocommenting on new lines ]]
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = vim.api.nvim_create_augroup("DisableAutocommenting", { clear = true }),
})

-- [[ Update file on Focus ]]
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
  group = vim.api.nvim_create_augroup("UpdateOnFocus", { clear = true }),
})

-- [[ Open lf when it's a Directory ]]
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if directory then
      require("lf").start()
    end
  end,
  group = vim.api.nvim_create_augroup("lf_ifDirectory", { clear = true }),
})

-- [[ Remove trailing whitespaces ]]
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\n\+\%$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  group = vim.api.nvim_create_augroup("RemoveTrailingWhitespaces", { clear = true }),
})

-- [[ Restore last cursor position ]]
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
        line > 1
        and line <= vim.fn.line "$"
        and vim.bo.filetype ~= "commit"
        and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"zz'
    end
  end,
})

-- [[ Reload xresources on write ]]
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = vim.fn.resolve(vim.fn.expand("~/.config/x11/xresources")),
  callback = function()
    -- cmd([[!xrdb % ; killall -USR1 st ; renew-dwm ; notify-send " - xresources reloaded"]])
    vim.cmd([[!xrdb % ; killall -USR1 st ; renew-dwm]])
  end,
  group = vim.api.nvim_create_augroup("ReloadXresources", { clear = true }),
})

-- [[ Restore cursor shape on exit]]
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd("set guicursor=a:hor20-blinkon500-blinkoff500-blinkwait700")
  end,
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
})

-- [[ Recompile suckless software on write and show notification ]]
local function recompile(path)
  vim.api.nvim_create_augroup("RecompileGroup_" .. path, { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = vim.fn.resolve(vim.fn.expand(path)),
    callback = function()
      local dir = vim.fn.fnamemodify(path, ":h")
      local shell_cmd = string.format("cd %s && sudo make install && renew-dwm && notify-send '  refresh complete'", dir)
      vim.cmd("!" .. shell_cmd)
    end,
  })
end

recompile("~/.config/suckless/dwm/config.h")
recompile("~/.config/suckless/dmenu/config.h")
recompile("~/.config/suckless/st/config.h")
recompile("~/.config/suckless/dwmblocks/config.h")
recompile("~/.config/suckless/slock/config.h")

--[[ Close nvim if toggleterm or Outline is the last buffer ]]
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    if
        vim.fn.tabpagenr("$") == 1
        and vim.fn.winnr("$") == 1
        and (vim.bo.ft == "toggleterm" or vim.bo.ft == "Outline")
    then
      vim.cmd("bd! | q")
    end
  end,
  group = vim.api.nvim_create_augroup("CloseLast", { clear = true }),
})

vim.cmd([[
  command -bar -nargs=? -complete=help HelpCurwin call HelpCurwin(<q-args>)

  let g:did_open_help = v:false

  function! HelpCurwin(subject) abort
    let mods = 'silent noautocmd keepalt'
    if !g:did_open_help
      execute mods .. ' help'
      execute mods .. ' helpclose'
      let g:did_open_help = v:true
    endif
    if !empty(getcompletion(a:subject, 'help'))
      execute mods .. ' edit ' .. &helpfile
      set buftype=help
    endif
    return 'help ' .. a:subject
  endfunction
]])

-- Function to check if the buffer is empty
local function is_buffer_empty(buf)
  local line_count = vim.api.nvim_buf_line_count(buf)
  if line_count > 1 then
    return false
  end
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  return lines[1] == ''
end

-- Function to close all empty buffers if the current buffer is 'help'
local function close_empty_buffers_if_help()
  local current_buf = vim.api.nvim_get_current_buf()
  if vim.bo.ft == 'help' then
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
      if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and is_buffer_empty(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = close_empty_buffers_if_help,
  group = vim.api.nvim_create_augroup("help_in_fullscreen", { clear = true }),
})

-- [[ Autosave ]]
-- vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
-- 	callback = function()
-- 		if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
-- 			vim.cmd("silent! w")
-- 		end
-- 	end,
--  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
-- })
