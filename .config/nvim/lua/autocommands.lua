-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.cmd([[ map <leader>cp :w! \| !compiler "%:p"<CR> ]])

vim.cmd([[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && &ft ==# 'Outline' | bd! | q | endif ]])
vim.cmd([[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && &ft ==# 'toggleterm' | bd! | q | endif ]])
vim.cmd([[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]])
vim.cmd([[ autocmd BufWritePre * let currPos = getpos(".") ]])
vim.cmd([[ autocmd BufWritePre * %s/\s\+$//e ]])
vim.cmd([[ autocmd BufWritePre * %s/\n\+\%$//e ]])
vim.cmd([[ autocmd BufWritePre * cal cursor(currPos[1], currPos[2]) ]])

-- Run xrdb whenever Xdefaults or Xresources are updated.
vim.cmd([[ autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults ]])
vim.cmd([[ autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb % ; kitty_colors ]])
vim.cmd([[ autocmd BufWritePost ~/dotfiles/.config/bspwm/bspwmrc !bspc wm -r; notify-send "bspwm reloaded"]])
vim.cmd([[ autocmd BufWritePost ~/dotfiles/.config/bspwm/sxhkdrc !pkill -USR1 -x sxhkd; notify-send "sxhkd reloaded" ]])
vim.cmd([[ autocmd BufWritePost ~/dotfiles/.config/bspwm/polybar/*.ini !sh ~/.config/bspwm/polybar/scripts/launch.sh &; notify-send "ploybar reloaded" ]])

vim.cmd([[ highlight DiagnosticVirtualTextError cterm=italic gui=italic guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticVirtualTextInfo cterm=italic gui=italic guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticVirtualTextWarn cterm=italic gui=italic guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticVirtualTextHint cterm=italic gui=italic guifg=#858694 ]])

vim.cmd([[ highlight DiagnosticFloatingError cterm=italic gui=italic guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticFloatingWarn cterm=italic gui=italic guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticFloatingInfo cterm=italic gui=italic guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticFloatingHint cterm=italic gui=italic guifg=#858694 ]])

vim.cmd([[ highlight DiagnosticSignError guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticSignWarn guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticSignInfo guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticSignHint guifg=#858694 ]])

vim.cmd([[ highlight DiagnosticUnderlineError cterm=underline gui=underline guisp=#858694 ]])
vim.cmd([[ highlight DiagnosticUnderlineWarn cterm=underline gui=underline guisp=#858694 ]])
vim.cmd([[ highlight DiagnosticUnderlineInfo cterm=underline gui=underline guisp=#858694 ]])
vim.cmd([[ highlight DiagnosticUnderlineHint cterm=underline gui=underline guisp=#858694 ]])

vim.cmd([[ highlight DiagnosticError guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticWarn guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticInfo guifg=#858694 ]])
vim.cmd([[ highlight DiagnosticHint guifg=#858694 ]])
