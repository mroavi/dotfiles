" Define cell_delimeter
let b:cell_delimeter = '^--- '
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call GoToNextDelim(b:cell_delimeter)<CR>z<CR>
nnoremap <buffer><silent> <M-k> :call GoToPrevDelim(b:cell_delimeter)<CR>z<CR>

" Handy header mappings
nnoremap <buffer><Leader>h1 m`<S-o>--=<Esc>77a=<Esc>yyjp``
nnoremap <buffer><Leader>h2 m`<S-o>---<Esc>77a-<Esc>yyjp``
nnoremap <buffer><Leader>h3 m`0dw :center 80<CR>hhv0r-A<Space><Esc>40A-<Esc>d77<Bar>I--<Space><Esc>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment characters and code
let b:commentary_format = '--%s'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Debug Utilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertPrintStatement()
  let l:last_search = substitute(@/,'\\<\|\\>\|\\V','','g')
  exe 'normal! ' . 'mz' . 'o' . 'print("' . l:last_search . ': ", ' . l:last_search . ')' . '`z'
endfunction
nnoremap <buffer> <Leader>pr :<C-u>call InsertPrintStatement()<CR>

function! InsertPrintInspectStatement()
  let l:last_search = substitute(@/,'\\<\|\\>\|\\V','','g')
  exe 'normal! ' . 'mz' . 'o' . 'print("' . l:last_search . ': ", vim.inspect(' . l:last_search . '))' . '`z'
endfunction
nnoremap <buffer> <Leader>pi :<C-u>call InsertPrintInspectStatement()<CR>

" Write and execute ( https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script )
nmap <buffer><silent> <Leader>e :write <Bar> luafile %<CR>

