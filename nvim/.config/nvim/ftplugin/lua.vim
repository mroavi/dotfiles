" Define cell_delimeter
let b:cell_delimeter = '--- '

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search(b:cell_delimeter, "W")<CR>zt
nnoremap <buffer><silent> <M-k> :call search(b:cell_delimeter, "bW")<CR>zt

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o>---<Esc>78a-<Esc>yyjp``

