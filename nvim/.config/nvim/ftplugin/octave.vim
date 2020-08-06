" No space between comment character and code
let b:commentary_format = '%%s'
" Insert comment character at the start of the line
let b:commentary_startofline = 1

" Jump to the next/prev %% delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^%%<CR>j:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^%%<CR>k:noh<CR>:set ws<CR>

" vim-slime
nmap <buffer> <M-CR> <Plug>SlimeSendCell
let b:slime_cell_delimiter = "^%%"

