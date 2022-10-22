" Define cell_delimeter
let b:cell_delimeter = '%%'

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <C-n> :call GoToNextDelim(b:cell_delimeter)<CR>
nnoremap <buffer><silent> <C-p> :call GoToPrevDelim(b:cell_delimeter)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment character and code
let b:commentary_format = '%%s'
