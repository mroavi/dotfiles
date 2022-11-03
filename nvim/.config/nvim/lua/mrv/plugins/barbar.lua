local vim = vim
vim.api.nvim_command([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.closable = v:false
]])

vim.keymap.set("n", "<M-h>", "<Cmd>:BufferPrevious<CR>")
vim.keymap.set("n", "<M-l>", "<Cmd>:BufferNext<CR>")
vim.keymap.set("n", "<Leader>1", "<Cmd>:BufferGoto 1<CR>")
vim.keymap.set("n", "<Leader>2", "<Cmd>:BufferGoto 2<CR>")
vim.keymap.set("n", "<Leader>3", "<Cmd>:BufferGoto 3<CR>")
vim.keymap.set("n", "<Leader>4", "<Cmd>:BufferGoto 4<CR>")
vim.keymap.set("n", "<Leader>5", "<Cmd>:BufferGoto 5<CR>")
vim.keymap.set("n", "<Leader>6", "<Cmd>:BufferGoto 6<CR>")
vim.keymap.set("n", "<Leader>7", "<Cmd>:BufferGoto 7<CR>")
vim.keymap.set("n", "<Leader>8", "<Cmd>:BufferGoto 8<CR>")
vim.keymap.set("n", "<Leader>9", "<Cmd>:BufferGoto 9<CR>")
vim.keymap.set("n", "<Leader>bd", "<Cmd>:BufferClose<CR>")
vim.keymap.set("n", "<Leader>bo", "<Cmd>:BufferCloseAllButCurrent<CR>")
vim.keymap.set("n", "<M-,>", "<Cmd>:BufferMovePrevious<CR>")
vim.keymap.set("n", "<M-.>", "<Cmd>:BufferMoveNext<CR>")
