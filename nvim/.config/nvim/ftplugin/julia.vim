" Define cell_delimeter
let b:cell_delimeter = '##'

" vim-tomux
let b:tomux_clipboard_paste = "include_string(Main, clipboard())"
let g:tomux_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
nnoremap <buffer><silent><expr> <Leader>rj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>:TomuxSend("julia\n")<CR>'
nnoremap <buffer><silent><expr> <Leader>rl ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>:TomuxSend("julia\n")<CR>'
nnoremap <buffer><silent> <Leader>rr :TomuxSend("exit()\n")<CR>:sl 50m<CR>:TomuxSend("julia\n")<CR>
nnoremap <buffer><silent> <Leader>rk :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>
nnoremap <buffer><silent> <Leader>cl :TomuxSend("clr()\n")<CR>

" Jump to the next/prev cell delimeter
nnoremap <buffer><silent> <M-j> :call GoToNextDelim(b:cell_delimeter)<CR>z<CR>
nnoremap <buffer><silent> <M-k> :call GoToPrevDelim(b:cell_delimeter)<CR>z<CR>

" Handy header mappings
nnoremap <buffer><Leader>m1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>m2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>m3 m`0dw :center 80<cr>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``

" julia-vim
noremap <Leader>tf :call julia#toggle_function_blockassign()<CR>

