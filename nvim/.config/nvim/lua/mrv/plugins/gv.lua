local utils = require('mrv.utils')
utils.remap("n", "<Leader>gv", "<Cmd>:GV<CR>")
utils.remap("n", "<Leader>glg", "<Cmd>:GV<CR>")

-- Emulates the zsh glg alias in nvim's command line
vim.cmd('cnoreabbrev glg  GV')

