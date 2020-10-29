" No space between comment character and code
let b:commentary_format = '#%s'

" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'
let g:ipython_cell_tag = '##'

nnoremap <buffer> <Leader>rr  :IPythonCellRun<CR>
nnoremap <buffer> <M-CR>      :IPythonCellExecuteCell<CR>
nnoremap <buffer> <M-k>       :IPythonCellPrevCell<CR>
nnoremap <buffer> <M-j>       :IPythonCellNextCell<CR>
nnoremap <buffer> <Leader>clr :IPythonCellClear<CR>

