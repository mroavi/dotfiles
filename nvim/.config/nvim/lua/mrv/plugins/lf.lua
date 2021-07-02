vim.g["lf#set_default_mappings"] = 0
vim.g["lf#replace_netrw"] = 1
vim.g["lf#layout"] = { window = { width = 0.9, height = 0.9, highlight = "Normal", } }
vim.g["lf#action"] = { ['<C-t>'] = 'tab split',
											 ['<C-x>'] = 'split',
											 ['<C-v>'] = 'vsplit', }

local utils = require("mrv.utils")
utils.remap("n", "<Leader>/", ":LfPicker %:p:h<CR>")

