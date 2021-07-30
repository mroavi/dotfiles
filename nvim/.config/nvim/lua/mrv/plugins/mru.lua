vim.g.MRU_File = "$HOME/.vim_mru_files"
vim.g.MRU_Max_Entries = 500
vim.g.MRU_Exclude_Files = "\\.git"
vim.g.MRU_Window_Height = 15

local utils = require('mrv.utils')
utils.remap("n", "<Leader>mr", "<Cmd>MRU<CR>", {silent = true})

