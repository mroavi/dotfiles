vim.cmd("let g:MRU_File = '$HOME/.vim_mru_files'")
vim.cmd("let g:MRU_Max_Entries = 500")
vim.cmd("let g:MRU_Exclude_Files = '\\.git'")
vim.cmd("nnoremap <silent><Leader>mr :MRU<CR>")

