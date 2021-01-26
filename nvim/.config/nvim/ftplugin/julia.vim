" No space between comment character and code
let b:commentary_format = '#%s'

" Define cell_delimeter
let b:cell_delimeter = '##'

" julia-cell
let g:julia_cell_delimit_cells_by = 'tags'
let g:julia_cell_tag = b:cell_delimeter
nnoremap <buffer> <M-CR> :JuliaCellExecuteCell<CR>
nnoremap <buffer> <Leader>clr :JuliaCellClear<CR>
" Hack: Alacritty sends Ctrl+Shift+3 when Ctrl+Shift+Enter is pressed
nnoremap <buffer> <C-S-3> :JuliaCellRun<CR>

" vim-slime
let g:slime_cell_delimiter = b:cell_delimeter

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search('^' . b:cell_delimeter, "W")<CR>
nnoremap <buffer><silent> <M-k> :call search('^' . b:cell_delimeter, "bW")<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

" julia-vim
noremap <Leader>tf :call julia#toggle_function_blockassign()<CR>
