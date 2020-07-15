" Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
:setlocal cinkeys-=:

" Use Alt-{j,k} to jump to the next/prev /// marker
nnoremap <silent> <M-j> /\/\/\/<CR>:noh<CR>zzj
nnoremap <silent> <M-k> ?\/\/\/<CR>:noh<CR>zzk

