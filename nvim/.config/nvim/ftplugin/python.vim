"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-ipython-cell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'

" map <Leader>r to run script
nnoremap <buffer><Leader>r :IPythonCellRun<CR>

" Execute current cell
nnoremap <buffer> <M-CR> :IPythonCellExecuteCell<CR>

" Jump to the next/prev delimeter
nnoremap <buffer> <M-k> :IPythonCellPrevCell<CR>
nnoremap <buffer> <M-j> :IPythonCellNextCell<CR>
