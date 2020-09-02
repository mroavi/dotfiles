" No space between comment character and code
let b:commentary_format = '#%s'
" Insert comment character at the start of the line
let b:commentary_startofline = 1

" julia-cell
let g:julia_cell_delimit_cells_by = 'tags'
let g:julia_cell_tag = '##'
nnoremap <buffer> <M-CR> :JuliaCellExecuteCell<CR>
nnoremap <buffer> <Leader>clr :JuliaCellClear<CR>

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/##<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?##<CR>:noh<CR>:set ws<CR>

" Handy header mappings
nnoremap <buffer><Leader>1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

