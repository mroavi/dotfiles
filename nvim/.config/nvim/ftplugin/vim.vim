" No space between comment and code
let b:commentary_format='"%s'

" Handy header mappings
nnoremap <Leader>1 m`<S-o><Esc>80a"<Esc>yyjp``

" Advance to the next/previous "" delimeter
nnoremap <silent> <M-j> /^"" <CR>:noh<CR>zz
nnoremap <silent> <M-k> ?^"" <CR>:noh<CR>zz

