" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'

nnoremap <buffer> <Leader>r :IPythonCellRun<CR>
nnoremap <buffer> <M-CR>    :IPythonCellExecuteCell<CR>
nnoremap <buffer> <M-k>     :IPythonCellPrevCell<CR>
nnoremap <buffer> <M-j>     :IPythonCellNextCell<CR>
