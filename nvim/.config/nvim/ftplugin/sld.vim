" Maximum width of text that is being inserted
setlocal textwidth=78
setlocal colorcolumn=78

" Ascii border
nmap <Leader>b :.!toilet -w 200 -f term -F border<Cr>

" Next/prev slide mappings
nnoremap <silent><buffer> <Right> :n<Cr>
nnoremap <silent><buffer> <Left> :N<Cr>
nnoremap <silent><buffer> <Up> :n<Cr>
nnoremap <silent><buffer> <Down> :N<Cr>

" TODO: not working
let g:markdown_fenced_languages = ['python']
