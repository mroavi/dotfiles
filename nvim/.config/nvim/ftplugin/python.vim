" No space between comment character and code
let b:commentary_format = '#%s'

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
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:tomux_clipboard_paste = "paste -q"
" Start REPL cmd
let b:start_repl_cmd = 'python'
" Start REPL in a BOTTOM split with active buffer as CWD
nnoremap <buffer><silent><expr> <Leader>rj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'
" Start REPL in a RIGHT split with active buffer as CWD
nnoremap <buffer><silent><expr> <Leader>rl ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>'
" Restart REPL
nnoremap <buffer><silent> <Leader>rr :TomuxSend("exit()\n")<CR>:sl 50m<CR>:TomuxSend(b:start_repl_cmd . "\n")<CR>
" Kill REPL
nnoremap <buffer><silent> <Leader>rk :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>
" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("print(\"\\n\" * 100)\n")<CR>
" Run file
nnoremap <buffer><silent><expr> <C-S-Cr> ':TomuxSend("exec(open(\"' . expand('%:p') . '\").read())\n")<CR>'

