" No space between comment and code
let b:commentary_format = '//%s'
" Add comment characters at the start of the line
let b:commentary_startofline = 1

" Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
setlocal cinkeys-=:

" Jump to the next/prev /// delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^\/\/\/<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^\/\/\/<CR>:noh<CR>:set ws<CR>

