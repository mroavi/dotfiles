" Maximum width of text that is being inserted
setlocal textwidth=78
setlocal colorcolumn=78

" Ascii border
nmap <Leader>b :.!toilet -w 200 -f term -F border<Cr>

" Next/prev slide mappings
nnoremap <silent><buffer> <Right> :n<Cr>
nnoremap <silent><buffer> <Left> :N<Cr>
nmap <silent><buffer> <Down> <Right>
nmap <silent><buffer> <Up> <Left>

" TODO: not working
let g:markdown_fenced_languages = ['python']
