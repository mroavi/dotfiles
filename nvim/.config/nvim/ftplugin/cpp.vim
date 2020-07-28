" Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
:setlocal cinkeys-=:

" Use Alt-{j,k} to jump to the next/prev /// marker
nnoremap <silent> <M-j> /\/\/\/<CR>:noh<CR>jzz
nnoremap <silent> <M-k> ?\/\/\/<CR>:noh<CR>kzz

" No space between comment and code
let b:commentary_format='//%s'

