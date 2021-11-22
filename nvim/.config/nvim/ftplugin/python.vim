" Define cell_delimeter
let b:cell_delimeter = '##'
" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search(b:cell_delimeter, "W")<CR>zt
nnoremap <buffer><silent> <M-k> :call search(b:cell_delimeter, "bW")<CR>zt

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No space between comment character and code
let b:commentary_format = '#%s'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tomux_use_clipboard = 1
let b:tomux_clipboard_paste = "paste -q"
" Start REPL cmd
let b:start_repl_cmd = 'python3.8 -m IPython'
" Start REPL cmd
let b:quit_repl_cmd = 'exit()'

" Start REPL in an already opened split
nnoremap <buffer><silent> <Leader>ts :TomuxSend(b:start_repl_cmd . "\n")<CR>
" Create a BOTTOM split with active buffer as CWD and start REPL
nnoremap <buffer><silent><expr> <Leader>tj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'
" Create a RIGHT split with active buffer as CWD and start REPL
nnoremap <buffer><silent><expr> <Leader>tl ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'
" Restart REPL (send first CTRL-c, and then restart)
nnoremap <buffer><silent> <Leader>tr :TomuxCommand("send-keys -t " . shellescape(g:tomux_config["target_pane"]) . " C-c")<CR>:TomuxSend(b:quit_repl_cmd . "\n")<CR>:sl 50m<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>
" Quit REPL (send first CTRL-c and then quit)
nnoremap <buffer><silent> <Leader>tq :TomuxCommand("send-keys -t " . shellescape(g:tomux_config["target_pane"]) . " C-c")<CR>:TomuxSend(b:quit_repl_cmd . "\n")<CR>
" Kill pane
nnoremap <buffer><silent> <Leader>tk :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>
" Execute file
nnoremap <buffer><silent><expr> <Leader>e ':TomuxSend("exec(open(\"' . expand('%:p') . '\").read())\n")<CR>'
" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("print(\"\\n\" * 100)\n")<CR>

