vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<C-h>", "<Cmd>:TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>:TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>:TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>:TmuxNavigateRight<CR>")
vim.keymap.set("i", "<C-h>", "<C-o>:TmuxNavigateLeft<CR>")
vim.keymap.set("i", "<C-j>", "<C-o>:TmuxNavigateDown<CR>")
vim.keymap.set("i", "<C-k>", "<C-o>:TmuxNavigateUp<CR>")
vim.keymap.set("i", "<C-l>", "<C-o>:TmuxNavigateRight<CR>")
