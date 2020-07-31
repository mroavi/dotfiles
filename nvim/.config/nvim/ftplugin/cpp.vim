" Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
setlocal cinkeys-=:

" Jump to the next/prev /// delimeter
nnoremap <buffer><silent> <M-j> /\/\/\/<CR>:noh<CR>j
nnoremap <buffer><silent> <M-k> ?\/\/\/<CR>:noh<CR>k

" No space between comment and code
let b:commentary_format='//%s'

