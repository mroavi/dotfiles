vim.g.floaterm_title = ""
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_autoclose = 1

vim.keymap.set("n", "<Bslash>", ":FloatermNew --cwd=<buffer><CR>", {silent = true})
vim.keymap.set("t", "<Bslash>", "<C-\\><C-n>:FloatermKill<CR>", {silent = true})
