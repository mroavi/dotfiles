" Define cell_delimeter
let b:cell_delimeter = '--- '

" Handy header mappings
nnoremap <buffer> <Leader>h1 m`<S-o>--=<Esc>77a=<Esc>yyjp``
nnoremap <buffer> <Leader>h2 m`<S-o>---<Esc>77a-<Esc>yyjp``
nnoremap <buffer> <Leader>h3 m`0dw :center 80<CR>hhv0r-A<Space><Esc>40A-<Esc>d77<Bar>I--<Space><Esc>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment characters and code
let b:commentary_format = '--%s'
