"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-julia-cell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use '##' to define cells instead of using marks
let g:julia_cell_delimit_cells_by = 'tags'

"autocmd FileType python,julia nnoremap <buffer> <F20> :JuliaCellRun<CR>
nnoremap <buffer> <F4> :JuliaCellRun<CR>

" Execute current cell
nnoremap <buffer> <M-CR> :JuliaCellExecuteCell<CR>

" Jump to the previous/next cell headers
nnoremap <buffer> <M-k> :JuliaCellPrevCell<CR>
nnoremap <buffer> <M-j> :JuliaCellNextCell<CR>

nnoremap <buffer> <Leader>cc :JuliaCellClear<CR>
nnoremap <buffer> <S-CR> :JuliaCellExecuteCellJump<CR>
