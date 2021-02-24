" No space between comment characters and code
let b:commentary_format = '//%s'

" Define cell_delimeter
let b:cell_delimeter = '///'

" Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
setlocal cinkeys-=:

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call GoToNextDelim(b:cell_delimeter)<CR>
nnoremap <buffer><silent> <M-k> :call GoToPrevDelim(b:cell_delimeter)<CR>
