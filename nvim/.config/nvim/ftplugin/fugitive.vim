" Jump to next file, hunk or revision when status screen is opened
exe "normal )"

" Support quitting with <Esc>
"nmap <buffer> <Esc> gq (old approach)
nnoremap <buffer> <Esc> <Plug>fugitive:gq

" Use j/k to jump to next/prev file, hunk or revision
nnoremap <buffer> j <Plug>fugitive:)
nnoremap <buffer> k <Plug>fugitive:(

" Use h/l to insert/remove inline diffs of the file under the cursor
nnoremap <buffer> h <Plug>fugitive:<
nnoremap <buffer> l <Plug>fugitive:>
