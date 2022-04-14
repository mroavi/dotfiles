" Define cell_delimeter
let b:cell_delimeter = '##'
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call GoToNextDelim(b:cell_delimeter)<CR>z<CR>
nnoremap <buffer><silent> <M-k> :call GoToPrevDelim(b:cell_delimeter)<CR>z<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Include `!` as part of a vim 'word'
setlocal iskeyword+=!

" Default config
let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}

" Julia's "paste" function
let b:tomux_clipboard_paste = 'include_string(Main, clipboard(), "' .. expand('%:p') .. '")'

" Start REPL cmd (activate environment found in the current dir or parents)
let b:start_repl_cmd = 'julia --project=@.'

" Start REPL in a RIGHT split with active buffer as CWD
function! OpenRightOf()
  let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}
  TomuxCommand("split-window -h -d -c " . expand("%:p:h"))
  TomuxSend(b:start_repl_cmd . "\n")
endfunction
nnoremap <buffer><silent> <Leader>tl :call OpenRightOf()<CR>

" Start REPL in a BOTTOM split with active buffer as CWD
function! OpenDownOf()
  let b:tomux_config = {"socket_name": "default", "target_pane": "{down-of}"}
  TomuxCommand("split-window -v -d -l 20% -c " . expand("%:p:h"))
  TomuxSend(b:start_repl_cmd . "\n")
endfunction
nnoremap <buffer><silent> <Leader>tj :call OpenDownOf()<CR>

" Execute buffer
function! ExecuteBuffer()
  write
  TomuxSend("\binclude(\"" . expand('%:p') . "\")\n")
endfunction
nnoremap <buffer><silent> <Leader>e :call ExecuteBuffer()<CR>

" Restart REPL
nnoremap <buffer><silent> <Leader>tr :TomuxSend("\bexit()\n")<CR>:sl 50m<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>

" Kill REPL
function! KillPane()
  TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))
endfunction
nnoremap <buffer><silent><Leader>tk :call KillPane()<CR>

" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("\bclr()\n")<CR>

" Run tests
let b:package = 'JunctionTrees'
nnoremap <buffer><silent> <Leader>tt :TomuxSend("\b]test " . b:package . "\n\b")<CR>

" Help under the cursor
nnoremap <buffer><silent> K :TomuxSend("\b?" . expand("<cword>") . "\n\b")<CR>

" Exit any REPL mode
nnoremap <buffer><silent> <BS> :TomuxSend("\b")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Misc
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
noremap <buffer><Leader>sh :call ToggleString('@show ', 'I')<CR>
noremap <buffer><Leader>pr :call ToggleString(' \|> println', 'A')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" julia-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <buffer><Leader>tf :call julia#toggle_function_blockassign()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Useful mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Inserts different kinds of headers
nnoremap <buffer><Leader>h1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>h2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>h3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``
