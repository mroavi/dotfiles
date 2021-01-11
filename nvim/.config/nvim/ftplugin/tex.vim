" No space between comment characters and code
let b:commentary_format = '%%s'

" Turn spell checking on
setlocal spell spelllang=en_us

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile files into a 'build' dir
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \}

let g:tex_flavor = 'latex'

" Configure qpdfview
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
  \ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'

" Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull .*',
      \]

