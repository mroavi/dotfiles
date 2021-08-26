" Define cell_delimeter
let b:cell_delimeter = '##'
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call GoToNextDelim(b:cell_delimeter)<CR>z<CR>
nnoremap <buffer><silent> <M-k> :call GoToPrevDelim(b:cell_delimeter)<CR>z<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:tomux_clipboard_paste = 'include_string(Main, clipboard(), "' .. expand('%:p') .. '")'
let g:tomux_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
" Start REPL in a BOTTOM split with active buffer as CWD (TODO: does now work
" if the current buffer's file name contains spaces)
nnoremap <buffer><silent><expr> <Leader>rj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>:TomuxSend("julia\n")<CR>'
" Start REPL in a RIGHT split with active buffer as CWD
nnoremap <buffer><silent><expr> <Leader>rl ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>:TomuxSend("julia\n")<CR>'
" Restart REPL
nnoremap <buffer><silent> <Leader>rr :TomuxSend("exit()\n")<CR>:sl 50m<CR>:TomuxSend("julia\n")<CR>
" Kill REPL
nnoremap <buffer><silent> <Leader>rk :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>
" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("clr()\n")<CR>
" Run tests
let b:package = 'DiscreteBayes'
nnoremap <buffer><silent> <Leader>rt :TomuxSend("\b]test " . b:package . "\n\b")<CR>
" Run file
nnoremap <buffer><silent><expr> <C-S-Cr> ':TomuxSend("include(\"' . expand('%:p') . '\")\n")<CR>'

" Adds/Removes the passed string to the start/end of the cursor line
function! ToggleString(str, insert_txt_cmd)
  let str = a:str .. ' '
  if (search(str, 'cn', line('.'))) || (search(str, 'cnb', line('.')))
    " Gets the current line, performs the substitution, and replaces it
    call setline(line('.'), substitute(getline('.'), str, '', ''))
  else
    silent exe "normal! m`" .. a:insert_txt_cmd .. str .. "\<Esc>``"
  endif 
endfunction
noremap <Leader>sh :call ToggleString('@show', 'I')<CR>
noremap <Leader>pr :call ToggleString(' \|> println', 'A')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" julia-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>tf :call julia#toggle_function_blockassign()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Inserts different kinds of headers
nnoremap <buffer><Leader>m1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

