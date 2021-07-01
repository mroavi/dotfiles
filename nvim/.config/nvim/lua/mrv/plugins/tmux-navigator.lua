vim.cmd("let g:tmux_navigator_no_mappings = 1")

local utils = require('mrv.utils')
utils.remap("n", "<C-h>", "<Cmd>:TmuxNavigateLeft<CR>")
utils.remap("n", "<C-j>", "<Cmd>:TmuxNavigateDown<CR>")
utils.remap("n", "<C-k>", "<Cmd>:TmuxNavigateUp<CR>")
utils.remap("n", "<C-l>", "<Cmd>:TmuxNavigateRight<CR>")
utils.remap("i", "<C-h>", "<C-o>:TmuxNavigateLeft<CR>")
utils.remap("i", "<C-j>", "<C-o>:TmuxNavigateDown<CR>")
utils.remap("i", "<C-k>", "<C-o>:TmuxNavigateUp<CR>")
utils.remap("i", "<C-l>", "<C-o>:TmuxNavigateRight<CR>")

