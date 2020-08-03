" julia-cell
let g:julia_cell_delimit_cells_by = 'tags'
nnoremap <buffer> <M-CR> :JuliaCellExecuteCell<CR>
nnoremap <buffer> <Leader>clr :JuliaCellClear<CR>
nnoremap <buffer> <S-CR> :JuliaCellExecuteCellJump<CR>

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^##<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^##<CR>:noh<CR>:set ws<CR>

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>2 m`<S-o># <Esc>78a-<Esc>yyjp``
