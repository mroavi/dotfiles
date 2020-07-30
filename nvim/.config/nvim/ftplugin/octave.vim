" Jump to the next/prev %% delimeter
nnoremap <buffer><silent> <M-j> /^%%<CR>:noh<CR>jzz
nnoremap <buffer><silent> <M-k> ?^%%<CR>:noh<CR>kzz

let g:slime_cell_delimiter = "%%"

