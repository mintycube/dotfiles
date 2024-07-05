-- Does not contain plugin specific keybinds
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>s", ":%s/<C-r><C-w>//gI<Left><Left><Left>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { desc = "chmod +x" })
vim.keymap.set("n", "<leader>cp", ':!compiler "%:p"<CR>', { desc = "run (C)om[P]iler script" })
vim.keymap.set("n", "<leader>sa", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace All" })
vim.keymap.set("n", "<leader>y", "<cmd>%yank<CR>", { desc = "Yank buffer" })
vim.keymap.set("n", "<A-;>", "<Esc>miA;<Esc>`i")
vim.keymap.set("n", "<leader>q", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-w>", ":bd<CR>", { silent = true })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<A-v>", ":vsplit<CR>", { silent = true })
vim.keymap.set("n", "<A-h>", ":split<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set('n', "gl", ':lua vim.diagnostic.open_float()<cr>')
vim.keymap.set("n", "<leader>cg", ":setlocal spell! spelllang=en_us<CR>", { desc = "Spellcheck", silent = true })
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })
vim.keymap.set("x", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("x", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("x", "<leader>h", [["ay:!dmenuhandler '<C-r>a'<cr>]])

vim.keymap.set("v", "<", "<gv^")
vim.keymap.set("v", ">", ">gv^")

vim.keymap.set("i", "<C-u>", "<Esc>viwUea")
vim.keymap.set("i", "<C-t>", "<Esc>b~lea")
vim.keymap.set("i", "<C-;>", "<Esc>miA;<Esc>`ii")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-Up>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-Down>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-Left>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-Right>", "<C-\\><C-N><C-w>l")

vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

vim.keymap.set("c", "<space>",
  function()
    local mode = vim.fn.getcmdtype()
    if mode == "?" or mode == "/" then
      return ".*"
    else
      return " "
    end
  end,
  { expr = true }
)

vim.keymap.set({ "x", "v", "n" }, ";", ":", { nowait = true })
vim.keymap.set({ "x", "v", "n" }, "<A-j>", ":m .+1<cr>==")
vim.keymap.set({ "x", "v", "n" }, "<A-k>", ":m .-2<cr>==")
