" Define cell_delimeter
let b:cell_delimeter = '\"\"\"'
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <C-j> :call search('^' . b:cell_delimeter . " ", "W")<CR>z<CR>
nnoremap <buffer><silent> <C-k> :call search('^' . b:cell_delimeter . " ", "bW")<CR>z<CR>

" Handy header mappings
nnoremap <buffer><Leader>h1 m`<S-o><Esc>80a"<Esc>yyjp``
nnoremap <buffer><Leader>h2 m`0dw :center 80<cr>hhv0r"A<Space><Esc>40A"<Esc>d80<Bar>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment and code
let b:commentary_format = '"%s'
