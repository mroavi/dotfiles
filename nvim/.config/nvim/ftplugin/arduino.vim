""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:serial_port = '/dev/ttyACM0'
let b:serial_baud = '9600'
"let b:board = 'arduino:avr:uno'
let b:board = 'arduino:avr:mega'

" Open a BOTTOM split with active buffer as CWD (TODO: does now work if the current buffer's file name contains spaces)
nnoremap <buffer><silent><expr> <Leader>tj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>'

" Open a RIGHT split with active buffer as CWD
nnoremap <buffer><silent><expr> <Leader>tl ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>'

" Kill pane
nnoremap <buffer><silent> <Leader>tK :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>

" Kill screen
nnoremap <buffer><silent> <Leader>tk :TomuxSend("Ky")<CR>

" Compile
let b:compile_cmd = ':TomuxSend("arduino-cli compile -b " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>tc b:compile_cmd . '<CR>'

" Upload
let b:upload_cmd = ':TomuxSend("arduino-cli upload -p " . b:serial_port . " --fqbn " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>tu b:upload_cmd . '<CR>'

" Open serial port
let b:screen_cmd = ':TomuxSend("screen " . b:serial_port . " " . b:serial_baud . "\n")'
nnoremap <buffer><silent><expr> <Leader>ts b:screen_cmd . '<CR>'

" Compile and upload (p stands for program)
nmap <buffer><silent> <Leader>tp <Leader>ac<Leader>au

" Compile, upload and open serial port
nmap <buffer><silent> <Leader>tt <Leader>ac<Leader>au<Leader>as
