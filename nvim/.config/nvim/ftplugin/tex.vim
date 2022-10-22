" Turn spell checking on
setlocal spell spelllang=en_us

" Maximum width of text that is being inserted
setlocal textwidth=80

" Define cell_delimeter
let b:cell_delimeter = '%%'

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <C-j> :call GoToNextDelim(b:cell_delimeter)<CR>
nnoremap <buffer><silent> <C-k> :call GoToPrevDelim(b:cell_delimeter)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment characters and code
let b:commentary_format = '%%s'
