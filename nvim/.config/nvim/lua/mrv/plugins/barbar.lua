local vim = vim
vim.api.nvim_command([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.closable = v:false
]])

local utils = require('mrv.utils')
utils.keymap("n", "<M-h>",      "<Cmd>:BufferPrevious<CR>")
utils.keymap("n", "<M-l>",      "<Cmd>:BufferNext<CR>")
utils.keymap("n", "<Leader>1",  "<Cmd>:BufferGoto 1<CR>")
utils.keymap("n", "<Leader>2",  "<Cmd>:BufferGoto 2<CR>")
utils.keymap("n", "<Leader>3",  "<Cmd>:BufferGoto 3<CR>")
utils.keymap("n", "<Leader>4",  "<Cmd>:BufferGoto 4<CR>")
utils.keymap("n", "<Leader>5",  "<Cmd>:BufferGoto 5<CR>")
utils.keymap("n", "<Leader>6",  "<Cmd>:BufferGoto 6<CR>")
utils.keymap("n", "<Leader>7",  "<Cmd>:BufferGoto 7<CR>")
utils.keymap("n", "<Leader>8",  "<Cmd>:BufferGoto 8<CR>")
utils.keymap("n", "<Leader>9",  "<Cmd>:BufferGoto 9<CR>")
utils.keymap("n", "<Leader>bd", "<Cmd>:BufferClose<CR>")
utils.keymap("n", "<Leader>bo", "<Cmd>:BufferCloseAllButCurrent<CR>")
utils.keymap("n", "<M-,>",      "<Cmd>:BufferMovePrevious<CR>")
utils.keymap("n", "<M-.>",      "<Cmd>:BufferMoveNext<CR>")
