" Turn spell checking on
:setlocal spell spelllang=en_us

" Color misspelled words
:hi SpellBad cterm=underline ctermfg=4

" Use k and j to move through wrapped lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
