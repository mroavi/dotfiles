" Define cell_delimeter
let b:cell_delimeter = '---'

let g:slime_cell_delimiter = b:cell_delimeter
nmap <buffer> <M-CR> <Plug>SlimeSendCell

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search('^' . b:cell_delimeter, "W")<CR>
nnoremap <buffer><silent> <M-k> :call search('^' . b:cell_delimeter, "bW")<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o>-- <Esc>78a=<Esc>yyjp``

