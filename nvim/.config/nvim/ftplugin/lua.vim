" Define cell_delimeter
let b:cell_delimeter = '^--- '
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call GoToNextDelim(b:cell_delimeter)<CR>
nnoremap <buffer><silent> <M-k> :call GoToPrevDelim(b:cell_delimeter)<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o>--=<Esc>77a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o>---<Esc>77a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<CR>hhv0r-A<Space><Esc>40A-<Esc>d77<Bar>I--<Space><Esc>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment characters and code
let b:commentary_format = '--%s'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Debug Utilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <buffer><Leader>de :exe "normal! o" . substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>

function! InsertPrintStatement()
  let l:last_search = substitute(@/,'\\<\|\\>\|\\V','','g')
  exe 'normal! o' . 'print("' . l:last_search . ': ", ' . l:last_search . ')'
endfunction
nnoremap <buffer> <Leader>pr :<C-u>call InsertPrintStatement()<CR>

function! InsertPrintInspectStatement()
  let l:last_search = substitute(@/,'\\<\|\\>\|\\V','','g')
  exe 'normal! o' . 'print("' . l:last_search . ': ", vim.inspect(' . l:last_search . '))'
endfunction
nnoremap <buffer> <Leader>pi :<C-u>call InsertPrintInspectStatement()<CR>

