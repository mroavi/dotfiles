vim.g.MRU_File = "$HOME/.vim_mru_files"
vim.g.MRU_Max_Entries = 500
vim.g.MRU_Exclude_Files = "\\.git"

local utils = require('mrv.utils')
utils.remap("n", "<Leader>mr", ":MRU<CR>", {silent = true})

