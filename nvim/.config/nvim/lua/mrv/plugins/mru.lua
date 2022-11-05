vim.g.MRU_File = "$HOME/.vim_mru_files"
vim.g.MRU_Max_Entries = 1000
--vim.g.MRU_Exclude_Files = "\\.git"
vim.g.MRU_Window_Height = 15
vim.g.MRU_Set_Alternate_File = 1

vim.keymap.set("n", "<Leader>R", "<Cmd>MRU<CR>j", { silent = true })

vim.cmd [[
let MRU_Filename_Format = { 'formatter': "fnamemodify(v:val, ':p:h:t') .. '/' .. fnamemodify(v:val, ':p:t') .. ' (' .. v:val .. ')'", 'parser':'(\zs.*\ze)', 'syntax': '^.\{-}\ze('}
]]
