""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: move to tomux?

let b:serial_port = '/dev/ttyACM0'
let b:serial_baud = '9600'
"let b:board = 'arduino:avr:uno'
let b:board = 'arduino:avr:mega'

" Start REPL in a RIGHT split with active buffer as CWD
function! OpenRightOf()
  let b:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}
  TomuxCommand("split-window -h -d -c " . expand("%:p:h"))
  "TomuxSend(b:start_repl_cmd . "\n")
endfunction
nnoremap <buffer><silent> <Leader>tl :call OpenRightOf()<CR>

" Start REPL in a BOTTOM split with active buffer as CWD
function! OpenDownOf()
  let b:tomux_config = {"socket_name": "default", "target_pane": "{down-of}"}
  TomuxCommand("split-window -v -d -l 20% -c " . expand("%:p:h"))
  "TomuxSend(b:start_repl_cmd . "\n")
endfunction
nnoremap <buffer><silent> <Leader>tj :call OpenDownOf()<CR>

" Kill pane
function! KillPane()
  TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))
endfunction
nnoremap <buffer><silent><Leader>tk :call KillPane()<CR>

" Kill screen
nnoremap <buffer><silent> <Leader>tK :TomuxSend("Ky")<CR>

" Compile
let b:compile_cmd = ':TomuxSend("arduino-cli compile -b " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>tc b:compile_cmd . '<CR>'

" Upload
let b:upload_cmd = ':TomuxSend("arduino-cli upload -p " . b:serial_port . " --fqbn " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>tu b:upload_cmd . '<CR>'

" Start screen and open serial port
let b:screen_cmd = ':TomuxSend("screen " . b:serial_port . " " . b:serial_baud . "\n")'
nnoremap <buffer><silent><expr> <Leader>ts b:screen_cmd . '<CR>'

" TODO: not working
" Compile and upload (p stands for program)
nmap <buffer><silent> <Leader>tp <Leader>ac<Leader>au

" TODO: not working
" Compile, upload and open serial port
nmap <buffer><silent> <Leader>tt <Leader>ac<Leader>au<Leader>as
