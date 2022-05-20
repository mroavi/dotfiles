""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Send the code directly (not using the clipboard)
let g:tomux_use_clipboard = 0

" Include `!` as part of a vim 'word'
setlocal iskeyword+=!

" Default config
let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}

" Compile and run
function! CompileAndExecute()
  write
  TomuxSend("cargo run\n")
endfunction
nnoremap <buffer><silent> <Leader>e :call CompileAndExecute()<CR>

" Clean project
function! CleanProject()
  write
  TomuxSend("cargo clean\n")
endfunction
nnoremap <buffer><silent> <Leader>tc :call CleanProject()<CR>

" Start REPL in a RIGHT split with active buffer as CWD
function! OpenRightOf()
  let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}
  TomuxCommand("split-window -h -d -c " . expand("%:p:h"))
endfunction
nnoremap <buffer><silent> <Leader>tl :call OpenRightOf()<CR>

" Start REPL in a BOTTOM split with active buffer as CWD
function! OpenDownOf()
  let b:tomux_config = {"socket_name": "default", "target_pane": "{down-of}"}
  TomuxCommand("split-window -v -d -l 20% -c " . expand("%:p:h"))
endfunction
nnoremap <buffer><silent> <Leader>tj :call OpenDownOf()<CR>

" Kill pane
function! KillPane()
  TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))
endfunction
nnoremap <buffer><silent><Leader>tk :call KillPane()<CR>

" Format file
function! Format()
  TomuxSend("rustfmt " . expand("%:p") . "\n")
endfunction
nnoremap <buffer><silent><Leader>tf :call Format()<CR>

" Clear REPL
nnoremap <buffer><silent> <Leader>cl :TomuxSend("clr\n")<CR>

" Run tests
nnoremap <buffer><silent> <Leader>tt :TomuxSend("cargo test\n")<CR>
