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

" Execute statements in file if preceded by a given pattern
" Inspired on: https://youtu.be/GDa7hrbcCB8?t=402
function! FindAndExecute()
  let startrow = search('\S*!!start')
  let endrow = search('\S*!!end')
  if (startrow != 0) && (endrow != 0)
    exe string(startrow + 1) . ',' . string(endrow - 1) . 'source'
    normal gg0
    redraw
  endif
endfunction

augroup find_and_execute
  autocmd!
  autocmd BufEnter *.sld call FindAndExecute()
augroup END
