""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:serial_port = '/dev/ttyACM0'
let b:serial_baud = '9600'
let b:board = 'arduino:avr:mega'

" Open a BOTTOM split with active buffer as CWD (TODO: does now work if the current buffer's file name contains spaces)
nnoremap <buffer><silent><expr> <Leader>aj ':TomuxCommand("split-window -v -d -l 20% -c ' . expand('%:p:h') . '")<CR>'

" Open a RIGHT split with active buffer as CWD
nnoremap <buffer><silent><expr> <Leader>al ':TomuxCommand("split-window -h -d -c ' . expand('%:p:h') . '")<CR>'

" Kill pane
nnoremap <buffer><silent> <Leader>aK :TomuxCommand("kill-pane -t " . shellescape(g:tomux_config["target_pane"]))<CR>

" Kill screen
nnoremap <buffer><silent> <Leader>ak :TomuxSend("Ky")<CR>

" Compile
let b:compile_cmd = ':TomuxSend("arduino-cli compile -b " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>ac b:compile_cmd . '<CR>'

" Upload
let b:upload_cmd = ':TomuxSend("arduino-cli upload -p " . b:serial_port . " --fqbn " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>au b:upload_cmd . '<CR>'

" Open serial port
let b:screen_cmd = ':TomuxSend("screen " . b:serial_port . " " . b:serial_baud . "\n")'
nnoremap <buffer><silent><expr> <Leader>as b:screen_cmd . '<CR>'

" Compile and upload (p stands for program)
nmap <buffer><silent> <Leader>ap <Leader>ac<Leader>au

" Compile, upload and open serial port
nmap <buffer><silent> <Leader>aa <Leader>ac<Leader>au<Leader>as

