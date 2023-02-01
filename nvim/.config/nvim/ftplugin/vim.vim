" Define cell_delimeter
let b:cell_delimeter = '^\"\"\" '

" Handy header mappings
nnoremap <buffer> <Leader>h1 m`<S-o><Esc>80a"<Esc>yyjp``
nnoremap <buffer> <Leader>h2 m`0dw :center 80<cr>hhv0r"A<Space><Esc>40A"<Esc>d80<Bar>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" No space between comment and code
let b:commentary_format = '"%s'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Debug utilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Insert a line below the current line that echos the content of the search register
function! Echo()
  let l:last_search = substitute(@/,'\\<\|\\>\|\\V','','g')
  exe 'normal! ' . 'mz' . 'o' . 'echom "' . l:last_search . ': " ' . l:last_search . '`z'
endfunction
nnoremap <buffer> <Leader>pr :<C-u>call Echo()<CR>

" Write and source ( https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script )
nmap <buffer><silent> <Leader>so :write <Bar> source %<CR>
