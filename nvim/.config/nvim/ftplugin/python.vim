" No space between comment and code
let b:commentary_format = '#%s'
" Insert comment character at the start of the line
let b:commentary_startofline = 1

" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'

nnoremap <buffer> <Leader>r :IPythonCellRun<CR>
nnoremap <buffer> <M-CR>    :IPythonCellExecuteCell<CR>
nnoremap <buffer> <M-k>     :IPythonCellPrevCell<CR>
nnoremap <buffer> <M-j>     :IPythonCellNextCell<CR>

