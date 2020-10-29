" No space between comment characters and code
let b:commentary_format = '//%s'
" Insert comment characters at the start of the line
let b:commentary_startofline = 0

nnoremap <buffer> <leader>am :ArduinoVerify<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>
nnoremap <buffer> <leader>as :ArduinoChoosePort<CR>
