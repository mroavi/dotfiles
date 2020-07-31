" Jump to the next/prev %% delimeter
nnoremap <buffer><silent> <M-j> /^%%<CR>:noh<CR>j
nnoremap <buffer><silent> <M-k> ?^%%<CR>:noh<CR>k

let g:slime_cell_delimiter = "%%"

