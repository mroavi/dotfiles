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
""" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment characters and code
let b:commentary_format = '--%s'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Debug Utilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Write and execute (https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script)
nmap <buffer><silent> <Leader>e :write<CR>:luafile %<CR>

"""""""""""""""""""""" Execute motion/textobject of code """""""""""""""""""""""

" Works for Lua and Vim (:h map-operator)
" - https://vi.stackexchange.com/a/5497/27039
" - https://vi.stackexchange.com/a/25507/27039
" Interface Lua function that gets the row and col of the '<' and '>' marks
lua function _G.buf_sel_start() return vim.api.nvim_buf_get_mark(0, '<')[1] end
lua function _G.buf_sel_end() return vim.api.nvim_buf_get_mark(0, '>')[1] end
" Function that gets executed after the motion is finished
function! SourceVisualText(type)
  " Yank the text covered by the motion/textobject
  silent exe 'normal! `[v`]Vy'    
  " Make a range with the selection start and end row numbers with "source"
  let @z = v:lua.buf_sel_start() . "," . v:lua.buf_sel_end() . "source"
  " Execute content of the z register
  @z
  " Restore the view of the current window (mainly to remember the cursor pos)
  call winrestview(g:view)
endfunction

"" Use either this line which does not support mapping predefined motions/textobjects
"nnoremap <silent> s :let g:view=winsaveview()<Bar>set opfunc=SourceVisualText<CR>g@

" or these lines that do support them
" E.g, here we map Alt+Enter to `sic`, which executes the current cell
noremap <SID>Operator :let g:view=winsaveview()<Bar>set opfunc=SourceVisualText<CR>g@
noremap <unique> <script> <silent> <Plug>LuaMotionSend <SID>Operator
nmap <buffer> s <Plug>LuaMotionSend
nmap <buffer> <M-Cr> sic

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

