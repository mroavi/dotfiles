" No space between comment and code
let b:commentary_format = '"%s'

" Define cell_delimeter
let b:cell_delimeter = '\"\"\"'
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search('^' . b:cell_delimeter . " ", "W")<CR>z<CR>
nnoremap <buffer><silent> <M-k> :call search('^' . b:cell_delimeter . " ", "bW")<CR>z<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o><Esc>80a"<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`0dw :center 80<cr>hhv0r"A<Space><Esc>40A"<Esc>d80<Bar>``

