" Jump to next file, hunk or revision when status screen is opened
exe "normal )"

" Support quitting with <Esc>
"nmap <buffer> <Esc> gq (old approach)
nnoremap <buffer> <Esc> <Plug>fugitive:gq

" Keep alternate file after opening a file with <Cr>
" https://github.com/tpope/vim-fugitive/issues/2040#issuecomment-1222737090
nmap <buffer> <Cr> .keepalt Gedit<Cr>

" Use j/k to jump to next/prev file, hunk or revision
nnoremap <buffer> j <Plug>fugitive:)
nnoremap <buffer> k <Plug>fugitive:(

" Use h/l to insert/remove inline diffs of the file under the cursor
nnoremap <buffer> h <Plug>fugitive:<
nnoremap <buffer> l <Plug>fugitive:>
