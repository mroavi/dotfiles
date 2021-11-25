vim.g["lf#set_default_mappings"] = false
vim.g["lf#replace_netrw"] = true
vim.g["lf#layout"] = { window = { width = 0.9, height = 0.9, highlight = "Normal", } }
vim.g["lf#action"] = { ['<C-t>'] = 'tab split',
                       ['<C-x>'] = 'split',
                       ['<C-a>'] = 'arga', -- add to arglist
                       --['<C-v>'] = 'vsplit', -- conflicts with blockwise visual mode (needed for batch rename)
                     }

local utils = require("mrv.utils")
utils.remap("n", "<Leader>\\",
            "expand('%') == '' ? '<Cmd>Lp %:p:h<CR>' : '<Cmd>Lp %<CR>'",
            {noremap = true, expr = true})

