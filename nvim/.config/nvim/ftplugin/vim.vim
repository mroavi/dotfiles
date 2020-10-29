" No space between comment and code
let b:commentary_format = '"%s'

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o><Esc>80a"<Esc>yyjp``
nnoremap <buffer><Leader>2 m`0dw :center 80<cr>hhv0r"A<Space><Esc>40A"<Esc>d80<Bar>``

" Jump to the next/prev "" delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^"" <CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^"" <CR>:noh<CR>:set ws<CR>

