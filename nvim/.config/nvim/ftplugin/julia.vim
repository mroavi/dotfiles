"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-julia-cell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use '##' to define cells instead of using marks
let g:julia_cell_delimit_cells_by = 'tags'

"autocmd FileType python,julia nnoremap <buffer> <F20> :JuliaCellRun<CR>
nnoremap <buffer> <F4> :JuliaCellRun<CR>

" Execute current cell
nnoremap <buffer> <M-CR> :JuliaCellExecuteCell<CR>

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> /##<CR>:noh<CR>zz
nnoremap <buffer><silent> <M-k> ?##<CR>:noh<CR>zz

nnoremap <buffer> <Leader>cc :JuliaCellClear<CR>
nnoremap <buffer> <S-CR> :JuliaCellExecuteCellJump<CR>

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>2 m`<S-o># <Esc>78a-<Esc>yyjp``
