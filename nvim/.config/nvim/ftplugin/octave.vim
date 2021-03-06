" No space between comment character and code
let b:commentary_format = '%%s'

" Define cell_delimeter
let b:cell_delimeter = '%%'

" Jump to the next/prev delimeter
nnoremap <buffer><silent> <M-j> :call search(b:cell_delimeter, "W")<CR>zt
nnoremap <buffer><silent> <M-k> :call search(b:cell_delimeter, "bW")<CR>zt

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search(b:cell_delimeter, "W")<CR>
nnoremap <buffer><silent> <M-k> :call search(b:cell_delimeter, "bW")<CR>

