" No space between comment characters and code
let b:commentary_format = '//%s'

" Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
setlocal cinkeys-=:

" Jump to the next/prev /// delimeter
nnoremap <buffer><silent> <M-j> :set nows<CR>/^\/\/\/<CR>:noh<CR>:set ws<CR>
nnoremap <buffer><silent> <M-k> :set nows<CR>?^\/\/\/<CR>:noh<CR>:set ws<CR>
