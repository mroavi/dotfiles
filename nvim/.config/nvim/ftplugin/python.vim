" No space between comment character and code
let b:commentary_format = '#%s'

" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'
let g:ipython_cell_tag = '##'

" Use ipython's %cpaste magic function
let g:slime_python_ipython = 1

nnoremap <buffer> <Leader>rr  :IPythonCellRun<CR>
nnoremap <buffer> <M-CR>      :IPythonCellExecuteCell<CR>
nnoremap <buffer> <M-k>       :IPythonCellPrevCell<CR>
nnoremap <buffer> <M-j>       :IPythonCellNextCell<CR>
nnoremap <buffer> <Leader>clr :IPythonCellClear<CR>

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

