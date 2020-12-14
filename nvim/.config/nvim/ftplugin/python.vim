" No space between comment character and code
let b:commentary_format = '#%s'

" vim-slime
let g:slime_python_ipython = 1
let g:slime_cell_delimiter = "##"
"nmap <buffer> <M-CR> <Plug>SlimeSendCell

" vim-ipython-cell
nnoremap <buffer> <Leader>rr  :IPythonCellRun<CR>
nnoremap <buffer> <Leader>clr :IPythonCellClear<CR>
nnoremap <buffer> <M-CR> :IPythonCellExecuteCell<CR> 

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/##<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?##<CR>:noh<CR>:set ws<CR>

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

