vim.g.floaterm_title = ""
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_autoclose = 1

local utils = require('mrv.utils')
utils.remap("n", "<Bslash>", ":FloatermNew --cwd=<buffer><CR>", {silent = true})
utils.remap("t", "<Bslash>", "<C-\\><C-n>:FloatermKill<CR>", {silent = true})

