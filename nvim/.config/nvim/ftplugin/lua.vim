let g:slime_cell_delimiter = "---"
nmap <buffer> <M-CR> <Plug>SlimeSendCell

" Jump to the next/prev ## delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/---<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?---<CR>:noh<CR>:set ws<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o>-- <Esc>78a=<Esc>yyjp``

