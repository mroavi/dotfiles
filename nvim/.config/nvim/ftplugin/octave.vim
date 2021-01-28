" No space between comment character and code
let b:commentary_format = '%%s'

" Define cell_delimeter
let b:cell_delimeter = '%%'

" vim-slime
nmap <buffer> <M-CR> <Plug>SlimeSendCell
let b:slime_cell_delimiter = b:cell_delimeter

" Jump to the next/prev %% delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^%%<CR>j:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^%%<CR>k:noh<CR>:set ws<CR>

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search(b:cell_delimeter, "W")<CR>
nnoremap <buffer><silent> <M-k> :call search(b:cell_delimeter, "bW")<CR>

