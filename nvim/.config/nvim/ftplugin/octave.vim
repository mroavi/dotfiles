" No space between comment and code
let b:commentary_format = '%%s'
" Insert comment character at the start of the line
let b:commentary_startofline = 1

" Jump to the next/prev %% delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^%%<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^%%<CR>:noh<CR>:set ws<CR>

let g:slime_cell_delimiter = "%%"

