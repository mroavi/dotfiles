local vim = vim
vim.api.nvim_command([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.closable = v:false
]])

local utils = require('mrv.utils')
utils.remap("n", "<M-h>",			 "<CMD>:BufferPrevious<CR>")
utils.remap("n", "<M-l>",			 "<CMD>:BufferNext<CR>")
utils.remap("n", "<Leader>1",  "<CMD>:BufferGoto 1<CR>")
utils.remap("n", "<Leader>2",  "<CMD>:BufferGoto 2<CR>")
utils.remap("n", "<Leader>3",  "<CMD>:BufferGoto 3<CR>")
utils.remap("n", "<Leader>4",  "<CMD>:BufferGoto 4<CR>")
utils.remap("n", "<Leader>5",  "<CMD>:BufferGoto 5<CR>")
utils.remap("n", "<Leader>6",  "<CMD>:BufferGoto 6<CR>")
utils.remap("n", "<Leader>7",  "<CMD>:BufferGoto 7<CR>")
utils.remap("n", "<Leader>8",  "<CMD>:BufferGoto 8<CR>")
utils.remap("n", "<Leader>9",  "<CMD>:BufferGoto 9<CR>")
utils.remap("n", "<Leader>bd", "<CMD>:BufferClose<CR>")
utils.remap("n", "<Leader>bo", "<CMD>:BufferCloseAllButCurrent<CR>")
utils.remap("n", "<M-,>",      "<CMD>:BufferMovePrevious<CR>")
utils.remap("n", "<M-.>",			 "<CMD>:BufferMoveNext<CR>")

