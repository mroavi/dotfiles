" From the vim docs:
" If your '{' or '}' are not in the first column, and you would like to use
" "[[" and "]]" anyway, try these mappings:  

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>
