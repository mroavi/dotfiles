" Define cell_delimeter
let b:cell_delimeter = '^##\? '

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <buffer><Leader>vi :lua require('mrv.utils').toggle_string(' {visibility="hidden"}', 'A')<CR>
