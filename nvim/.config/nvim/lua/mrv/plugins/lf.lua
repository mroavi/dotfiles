vim.cmd("let g:lf#set_default_mappings = 0")
vim.cmd("nnoremap <Leader>/ :LfPicker %:p:h<CR>")
vim.cmd("let g:lf#replace_netrw = 1")
vim.cmd("let g:lf#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Normal' } }")
vim.cmd("let g:lf#action = { '<c-t>': 'tab split', '<c-x>': 'split', '<c-v>': 'vsplit' }")

