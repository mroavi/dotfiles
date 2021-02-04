" No space between comment character and code
let b:commentary_format = '#%s'

" Define cell_delimeter
let b:cell_delimeter = '##'

" vim-tomux
let b:tomux_clipboard_paste = "include_string(Main, clipboard())"
let g:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}
nnoremap <buffer><silent> <Leader>jl :TomuxCommand("split-window -h -d")<CR>:TomuxSend("julia\n")<CR>
nnoremap <buffer><silent> <Leader>jk :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>
nnoremap <buffer><silent> <Leader>jr :TomuxSend("exit()\n")<CR>:sl 50m<CR>:TomuxSend("julia\n")<CR>
nnoremap <buffer><silent> <Leader>cl :TomuxSend("clr()\n")<CR>

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call search(b:cell_delimeter, "W")<CR>
nnoremap <buffer><silent> <M-k> :call search(b:cell_delimeter, "bW")<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

" julia-vim
noremap <Leader>tf :call julia#toggle_function_blockassign()<CR>
