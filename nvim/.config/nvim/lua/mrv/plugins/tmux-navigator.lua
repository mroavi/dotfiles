vim.g.tmux_navigator_no_mappings = 1

local utils = require('mrv.utils')
utils.keymap("n", "<C-h>", "<Cmd>:TmuxNavigateLeft<CR>")
utils.keymap("n", "<C-j>", "<Cmd>:TmuxNavigateDown<CR>")
utils.keymap("n", "<C-k>", "<Cmd>:TmuxNavigateUp<CR>")
utils.keymap("n", "<C-l>", "<Cmd>:TmuxNavigateRight<CR>")
utils.keymap("i", "<C-h>", "<C-o>:TmuxNavigateLeft<CR>")
utils.keymap("i", "<C-j>", "<C-o>:TmuxNavigateDown<CR>")
utils.keymap("i", "<C-k>", "<C-o>:TmuxNavigateUp<CR>")
utils.keymap("i", "<C-l>", "<C-o>:TmuxNavigateRight<CR>")

