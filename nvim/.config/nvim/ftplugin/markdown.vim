" Turn spell checking on
setlocal spell spelllang=en_us

" Suggest words from the active spell checking in the completion menu
set complete+=kspell

" Align markdown tables
vnoremap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`yypVr=``
nnoremap <buffer><Leader>m2 m`yypVr-``
nnoremap <buffer><Leader>m3 m`^i### <ESC>``4l
nnoremap <buffer><Leader>m4 m`^i#### <ESC>``5l
nnoremap <buffer><Leader>m5 m`^i##### <ESC>``6l
nnoremap <buffer><Leader>m6 m`^i###### <ESC>``7l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" markdown-preview.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>md :MarkdownPreview<CR>

let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {},
      \ 'flowchart_diagrams': {},
      \ 'content_editable': v:false,
      \ 'disable_filename': 1
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" delimitmate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:delimitMate_expand_space = 0

