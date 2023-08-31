" Define cell_delimeter
let b:cell_delimeter = '##'

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

" Make sure to have 'ipython' and 'tk' installed.
" 'tk' is needed to use the `%paste` magic function. (Source: https://superuser.com/a/549325/1087113)
" On Arch, you can install these with the following commands:
"   sudo pacman -S ipython
"   sudo pacman -S tk

" Default config
let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}

let g:tomux_use_clipboard = 1

" IPython's "paste" function
let b:tomux_clipboard_paste = "%paste -q"

" Start REPL cmd
let b:start_repl_cmd = 'python -m IPython'

" Exit REPL cmd
let b:quit_repl_cmd = 'exit()'

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

"" Restart REPL (send first CTRL-c, and then restart)
function! Restart()
  TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")
  TomuxSend(b:quit_repl_cmd . "\n")
  sl 50m
  TomuxSend(b:start_repl_cmd . "\n")
endfunction
nnoremap <buffer><silent> <Leader>tr :call Restart()<CR>

" Quit REPL (send first CTRL-c and then quit)
function! Quit()
  TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")
  TomuxSend(b:quit_repl_cmd . "\n")
endfunction
nnoremap <buffer><silent> <Leader>tq :call Quit()<CR>

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
