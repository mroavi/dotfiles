" Advance to the next/previous %% delimeter
nnoremap <silent> <M-j> /^%%<CR>:noh<CR>jzz
nnoremap <silent> <M-k> ?^%%<CR>:noh<CR>kzz

let g:slime_cell_delimiter = "%%"

