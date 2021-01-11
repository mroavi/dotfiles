" No space between comment characters and code
let b:commentary_format = '//%s'

nnoremap <buffer> <leader>am :ArduinoVerify<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>
nnoremap <buffer> <leader>as :ArduinoChoosePort<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-arduino
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:arduino_use_slime = 1
let g:arduino_serial_baud = 9600

nnoremap <buffer> <Leader>am :ArduinoVerify<CR>
nnoremap <buffer> <Leader>au :ArduinoUpload<CR>
nnoremap <buffer> <Leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <Leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <Leader>ap :ArduinoChooseProgrammer<CR>
nnoremap <buffer> <Leader>as :ArduinoChoosePort<CR>

