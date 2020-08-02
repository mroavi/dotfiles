" Jump to the next/prev %% delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^%%<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^%%<CR>:noh<CR>:set ws<CR>

let g:slime_cell_delimiter = "%%"

