vim.api.nvim_command([[
let g:floaterm_title = ""
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_autoclose = 1
]])

local utils = require('mrv.utils')
utils.remap("n", "<Bslash>", ":FloatermNew --cwd=<buffer><CR>", {silent = true})
utils.remap("t", "<Bslash>", "<C-\\><C-n>:FloatermKill<CR>", {silent = true})

