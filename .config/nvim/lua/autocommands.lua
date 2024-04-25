-- local vim.api.nvim_create_augroup = vim.api.nvim_create_augroup

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

-- [[ Recompile suckless software on write and show notification ]]
local function recompile(path)
  vim.api.nvim_create_augroup("RecompileGroup_" .. path, { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = vim.fn.resolve(vim.fn.expand(path)),
    callback = function()
      local dir = vim.fn.fnamemodify(path, ":h")
      local shell_cmd = string.format("cd %s && sudo make install && renew-dwm", dir)
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

-- [[ Autosave ]]
-- vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
-- 	callback = function()
-- 		if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
-- 			vim.cmd("silent! w")
-- 		end
-- 	end,
--  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
-- })
