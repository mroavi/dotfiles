vim.g["lf#set_default_mappings"] = false
vim.g["lf#replace_netrw"] = true
vim.g["lf#layout"] = { window = { width = 0.9, height = 0.9, highlight = "Normal", } }
vim.g["lf#action"] = { ['<C-t>'] = 'tab split', -- open in tab
                       ['<C-j>'] = 'split', -- open in horizontal split
                       ['<C-l>'] = 'vsplit', -- open in vertical split
                       ['<C-a>'] = '$arga', -- add to arglist
                     }

-- TODO: stopped working with Neovim 0.8
--vim.keymap.set("n", "<Leader>/",
--               "expand('%') == '' ? '<Cmd>Lp %:p:h<CR>' : '<Cmd>Lp %<CR>'",
--               {noremap = true, expr = true})

vim.cmd [[
nnoremap <expr> <Leader>/ expand('%') == '' ? '<Cmd>Lp %:p:h<CR>' : '<Cmd>Lp %<CR>'
]]
