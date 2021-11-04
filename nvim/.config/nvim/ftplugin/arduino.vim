""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:serial_port = '/dev/ttyACM0'
let b:serial_baud = '9600'
let b:board = 'arduino:avr:uno'

" Compile
let b:compile_cmd = ':TomuxSend("arduino-cli compile -b " . b:board . " ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>ac b:compile_cmd . '<CR>'

" Upload
let b:upload_cmd = ':TomuxSend("arduino-cli upload -p " . b:serial_port . " --fqbn arduino:avr:mega ' . expand('%:p') . '\n")'
nnoremap <buffer><silent><expr> <Leader>au b:upload_cmd . '<CR>'

" Open serial port
let b:screen_cmd = ':TomuxSend("sudo screen " . b:serial_port . " " . b:serial_baud . "\n")'
nnoremap <buffer><silent><expr> <Leader>as b:screen_cmd . '<CR>'

" Compile, upload and open serial port
nmap <buffer><silent> <Leader>ad <Leader>ac<Leader>au<Leader>as

