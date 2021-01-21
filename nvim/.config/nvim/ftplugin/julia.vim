" No space between comment character and code
let b:commentary_format = '#%s'

" julia-cell
let g:julia_cell_delimit_cells_by = 'tags'
let g:julia_cell_tag = '##'
nnoremap <buffer> <M-CR> :JuliaCellExecuteCell<CR>
nnoremap <buffer> <Leader>clr :JuliaCellClear<CR>
" Hack: Alacritty sends Ctrl+Shift+3 when Ctrl+Shift+Enter is pressed
nnoremap <buffer> <C-S-3> :JuliaCellRun<CR>

" vim-slime
let g:slime_cell_delimiter = "##"

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/##<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?##<CR>:noh<CR>:set ws<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

" julia-vim
noremap <Leader>jf :call julia#toggle_function_blockassign()<CR>
