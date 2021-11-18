" Jump to next file, hunk or revision when status screen is opened
exe "normal )"
" Support quitting  with <Esc>
nmap <buffer> <Esc> gq
" Use j/k to jump to next/prev file, hunk or revision
nmap <buffer> j )
nmap <buffer> k (
" Use h/l to insert/remove inline diffs of the file under the cursor
nmap <buffer> h <
nmap <buffer> l >

