-- Does not contain plugin specific keybinds
local map = vim.keymap.set

map('n' , "k"          , "v:count == 0 ? 'gk' : 'k'"            , { expr = true, silent = true })
map('n' , "j"          , "v:count == 0 ? 'gj' : 'j'"            , { expr = true, silent = true })
map('n' , "<leader>s"  , ":%s/<C-r><C-w>//gI<Left><Left><Left>"   )
map('n' , "<C-Left>"   , ":vertical resize -2<CR>"              , { silent = true })
map('n' , "<C-Right>"  , ":vertical resize +2<CR>"              , { silent = true })
map('n' , "<C-Up>"     , ":resize +2<CR>"                       , { silent = true })
map('n' , "<C-Down>"   , ":resize -2<CR>"                       , { silent = true })
map('n' , "J"          , "mzJ`z"                                  )
map('n' , "<C-d>"      , "<C-d>zz"                                )
map('n' , "<C-u>"      , "<C-u>zz"                                )
map('n' , "n"          , "nzzzv"                                  )
map('n' , "N"          , "Nzzzv"                                  )
map('n' , "<leader>x"  , "<cmd>!chmod +x %<CR>"                 , { desc = "chmod +x" })
map('n' , "<leader>cp" ,':!compiler "%:p"<CR>'                  , { desc = "run [C]om[P]iler script"})
map('n' , "<leader>s"  , ":%s/<C-r><C-w>//gI<Left><Left><Left>" , { desc = "Replace All" })
map('n' , "<leader>a"  , "<cmd>%yank<CR>"                       , { desc = "Yank buffer" })
map('n' , "<A-;>"      , "<Esc>miA;<Esc>`i"                       )
map('n' , "<leader>q"  , ":lua vim.diagnostic.open_float()<CR>" , { noremap = true, silent = true })
map('n' , "<C-w>"      , ":bd<CR>"                              , { silent = true })
map('n' , "<A-v>"      , ":vsplit<CR>"                          , { silent = true })
map('n' , "<A-h>"      , ":split<CR>"                           , { silent = true })

map('x' , "p"          , 'p:let @+=@0<CR>:let @"=@0<CR>'        , { silent = true })
map('x' , "k"          , ":m '<-2<cr>gv=gv"                       )
map('x' , "j"          , ":m '>+1<cr>gv=gv"                       )

map('v' , "<"          , "<gv^"                                   )
map('v' , ">"          , ">gv^"                                   )

map('i' , "<C-u>"      , "<Esc>viwUea"                            )
map('i' , "<C-t>"      , "<Esc>b~lea"                             )
map('i' , "<C-;>"      , "<Esc>miA;<Esc>`ii"                      )


map({'x','v','n'}      , ";"             , ":"                  , { nowait = true })
map({'x','v','n'}      , "<A-j>"         , ":m .+1<cr>=="         )
map({'x','v','n'}      , "<A-k>"         , ":m .-2<cr>=="         )
