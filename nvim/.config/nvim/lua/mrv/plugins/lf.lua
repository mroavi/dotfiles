vim.g["lf#set_default_mappings"] = false
vim.g["lf#replace_netrw"] = true
vim.g["lf#layout"] = { window = { width = 0.9, height = 0.9, highlight = "Normal", } }
vim.g["lf#action"] = { ['<C-t>'] = 'tab split', -- open in tab
                       ['<C-j>'] = 'split', -- horizontal split
                       ['<C-a>'] = 'arga', -- add to arglist
                       ['<C-l>'] = 'vsplit', -- vertical split
                     }

local utils = require("mrv.utils")
utils.keymap("n", "<Leader>/",
            "expand('%') == '' ? '<Cmd>Lp %:p:h<CR>' : '<Cmd>Lp %<CR>'",
            {noremap = true, expr = true})

