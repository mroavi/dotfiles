" Define cell_delimeter
let b:cell_delimeter = '^##\? '
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <C-n> :call GoToNextDelim(b:cell_delimeter)<CR>
nnoremap <buffer><silent> <C-p> :call GoToPrevDelim(b:cell_delimeter)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <buffer><Leader>vi :call ToggleString(' {visibility="hidden"}', 'A')<CR>
