" Define cell_delimeter
let b:cell_delimeter = '##'
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <C-j> :call search(b:cell_delimeter, "W")<CR>zt
nnoremap <buffer><silent> <C-k> :call search(b:cell_delimeter, "bW")<CR>zt

" Handy header mappings
nnoremap <buffer><Leader>h1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>h2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>h3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment character and code
let b:commentary_format = '#%s'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Default config
let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}

let g:tomux_use_clipboard = 1

" IPython's "paste" function
let b:tomux_clipboard_paste = "%paste -q"

" Start REPL cmd
let b:start_repl_cmd = 'python -m IPython'

" Exit REPL cmd
let b:quit_repl_cmd = 'exit()'

" Create a BOTTOM split with active buffer as CWD and start REPL
nnoremap <buffer><silent><expr> <Leader>tj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'

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

" Restart REPL (send first CTRL-c, and then restart)
nnoremap <buffer><silent> <Leader>tr :TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")<CR>:TomuxSend(b:quit_repl_cmd . "\n")<CR>:sl 50m<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>

" Quit REPL (send first CTRL-c and then quit)
nnoremap <buffer><silent> <Leader>tq :TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")<CR>:TomuxSend(b:quit_repl_cmd . "\n")<CR>

" Kill REPL
function! KillPane()
  TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))
endfunction
nnoremap <buffer><silent><Leader>tk :call KillPane()<CR>

" Execute buffer
function! ExecuteBuffer()
  write
  TomuxSend("exec(open(\"" . expand('%:p') . "\").read())\n")
endfunction
nnoremap <buffer><silent> <Leader>e :call ExecuteBuffer()<CR>

" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("print(\"\\n\" * 100)\n")<CR>

" Execute file
nnoremap <buffer><silent><expr> <Leader>e ':w<Bar>:TomuxSend("exec(open(\"' . expand('%:p') . '\").read())\n")<CR>'
