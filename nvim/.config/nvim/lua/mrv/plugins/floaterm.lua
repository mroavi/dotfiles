vim.api.nvim_command([[
nnoremap <silent> <Bslash> :FloatermNew --cwd=<buffer><CR>
tnoremap <silent> <Bslash> <C-\><C-n>:FloatermKill<CR>
let g:floaterm_title = ""
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_autoclose = 1
]])

