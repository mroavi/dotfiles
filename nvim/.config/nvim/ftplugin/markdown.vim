" Turn spell checking on
setlocal spell spelllang=en

" Suggest words from the active spell checking in the completion menu
setlocal complete+=kspell

" Maximum width of text that is being inserted
setlocal textwidth=80

" Align markdown tables
vnoremap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Handy header mappings
nnoremap <buffer><Leader>h1 m`yypVr=``
nnoremap <buffer><Leader>h2 m`yypVr-``
nnoremap <buffer><Leader>h3 m`^i### <ESC>``4l
nnoremap <buffer><Leader>h4 m`^i#### <ESC>``5l
nnoremap <buffer><Leader>h5 m`^i##### <ESC>``6l
nnoremap <buffer><Leader>h6 m`^i###### <ESC>``7l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
