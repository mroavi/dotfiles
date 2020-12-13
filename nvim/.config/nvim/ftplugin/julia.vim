" No space between comment character and code
let b:commentary_format = '#%s'

" Set vim-slime cell delimeter
let g:slime_cell_delimiter = "##"

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/##<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?##<CR>:noh<CR>:set ws<CR>

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

