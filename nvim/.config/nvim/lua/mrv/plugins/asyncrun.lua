vim.g.asyncrun_open = 10
vim.keymap.set("n", "<Leader>*", ":AsyncRun! -strip grep -R -n <cword><Cr>", {silent = false})
