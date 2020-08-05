" No space between comment and code
let b:commentary_format = '"%s'
" Add comment character at the start of the line
let b:commentary_startofline = 1

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o><Esc>80a"<Esc>yyjp``

" Jump to the next/prev "" delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^"" <CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^"" <CR>:noh<CR>:set ws<CR>

