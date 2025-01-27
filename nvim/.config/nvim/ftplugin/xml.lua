-- Use 4 spaces for indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Fold inner tag
vim.keymap.set('n', "zfit", [[:norm vitkojzf<Cr>]], { buffer = true, silent = true })
