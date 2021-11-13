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
" Start REPL cmd (activate environment found in the current dir or parents)
let b:start_repl_cmd = 'julia --project=@.'
" Start REPL in a BOTTOM split with active buffer as CWD (TODO: does now work if the current buffer's file name contains spaces)
nnoremap <buffer><silent><expr> <Leader>tj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'
" Start REPL in a RIGHT split with active buffer as CWD
nnoremap <buffer><silent><expr> <Leader>tl ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'
" Restart REPL
nnoremap <buffer><silent> <Leader>tr :TomuxSend("\bexit()\n")<CR>:sl 50m<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>
" Kill REPL
nnoremap <buffer><silent> <Leader>tk :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>
" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("\bclr()\n")<CR>
" Run tests
let b:package = 'DiscreteBayes'
nnoremap <buffer><silent> <Leader>tt :TomuxSend("\b]test " . b:package . "\n\b")<CR>
" Run file
nnoremap <buffer><silent><expr> <C-S-Cr> ':TomuxSend("\binclude(\"' . expand('%:p') . '\")\n")<CR>'
" Exit any REPL mode
nnoremap <buffer><silent> <BS> :TomuxSend("\b")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adds/Removes the passed string to the start/end of the cursor line
function! ToggleString(str, insert_txt_cmd)
  if (search(a:str, 'cn', line('.'))) || (search(a:str, 'cnb', line('.')))
    " Gets the current line, performs the substitution, and replaces it
    call setline(line('.'), substitute(getline('.'), a:str, '', ''))
  else
    silent exe "normal! m`" .. a:insert_txt_cmd .. a:str .. "\<Esc>``"
  endif 
endfunction
noremap <Leader>sh :call ToggleString('@show ', 'I')<CR>
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

