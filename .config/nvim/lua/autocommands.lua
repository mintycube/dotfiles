local fn = vim.fn
local bo = vim.bo
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- [[ Highlight on yank ]]
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ Disable Autocomments ]]
local autocomments = augroup("DisableAutocommenting", { clear = true })
autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = autocomments,
})

-- [[ Autosave ]]
local autosave = augroup("AutoSave", { clear = true })
autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
	callback = function()
		if bo.filetype ~= "" and bo.buftype == "" then
			cmd("silent! w")
		end
	end,
	group = autosave,
})

-- [[ Update file on Focus ]]
local update_on_focus = augroup("UpdateOnFocus", { clear = true })
autocmd("FocusGained", {
	callback = function()
		cmd("checktime")
	end,
	group = update_on_focus,
})

-- [[ Open lf when it's a Directory ]]
local lf = augroup("lf_ifDirectory", { clear = true })
autocmd("VimEnter", {
	callback = function(data)
		local directory = fn.isdirectory(data.file) == 1
		if directory then
			require("lf").start()
		end
	end,
	group = lf,
})

-- [[ Remove trailing whitespaces ]]
local rm_space = augroup("RemoveTrailingWhitespaces", { clear = true })
autocmd({ "BufWritePre" }, {
  pattern = {"*"},
  callback = function()
    local save_cursor = fn.getpos(".")
    cmd([[%s/\s\+$//e]])
    cmd([[%s/\n\+\%$//e]])
    fn.setpos(".", save_cursor)
  end,
  group = rm_space,
})

-- [[ Restore last cursor position ]]
autocmd('BufRead', {
  callback = function(opts)
    autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"zz]], 'nx', false)
        end
      end,
    })
  end,
})

-- [[ Reload xresources ]]
local reload_xresources = augroup("ReloadXresources", { clear = true })
local xresources_path = fn.resolve(fn.expand("~/.config/x11/xresources"))
autocmd({ "BufWritePost" }, {
  pattern = xresources_path,
  callback = function()
    cmd([[!xrdb % ; kitty_colors; notify-send " - xresources reloaded" " - kitty colors generated"]])
  end,
  group = reload_xresources,
})

-- [[ Reload bspwm ]]
local reload_bspwm = augroup("ReloadBspwm", { clear = true })
local bspwmrc_path = fn.resolve(fn.expand("~/.config/bspwm/bspwmrc"))
autocmd({ "BufWritePost" }, {
  pattern = bspwmrc_path,
  callback = function()
    cmd([[!bspc wm -r; notify-send " - bspwm reloaded"]])
  end,
  group = reload_bspwm,
})

-- [[ Reload sxhkd ]]
local reload_sxhkd = augroup("ReloadSxhkd", { clear = true })
local sxhkdrc_path = fn.resolve(fn.expand("~/.config/bspwm/sxhkdrc"))
autocmd({ "BufWritePost" }, {
  pattern = sxhkdrc_path,
  callback = function()
    cmd([[!pkill -USR1 -x sxhkd; notify-send " - sxhkd reloaded"]])
  end,
  group = reload_sxhkd,
})

-- function to return files under a folder and its subfolder as a table of strings
local function list_files_in_directory(directory)
  local file_list = {}
  local function recursive_list(path)
    for _, entry in ipairs(fn.readdir(path)) do
      local full_path = path .. '/' .. entry
      local is_directory = fn.isdirectory(full_path) == 1
      if is_directory and entry ~= '.' and entry ~= '..' then
        recursive_list(full_path)
      elseif not is_directory then
        table.insert(file_list, full_path)
      end
    end
  end
  recursive_list(directory)
  return file_list
end

-- [[ Reload polybar ]]
local polybar_files = list_files_in_directory(fn.resolve(fn.expand("~/.config/bspwm/polybar")))
local reload_polybar = augroup("ReloadPolybar", { clear = true })
autocmd({ "BufWritePost" }, {
  pattern = polybar_files,
  callback = function()
    cmd([[!sh ~/.config/bspwm/polybar/scripts/launch.sh &; notify-send " - ploybar reloaded"]])
  end,
  group = reload_polybar,
})

--[[ Close nvim if toggleterm or Outline is the last buffer ]]
local close_last = augroup("CloseLast", { clear = true })
autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    if fn.tabpagenr('$') == 1 and fn.winnr('$') == 1 and (bo.ft == 'toggleterm' or bo.ft == 'Outline') then
      cmd('bd! | q')
    end
  end,
  group = close_last,
})

