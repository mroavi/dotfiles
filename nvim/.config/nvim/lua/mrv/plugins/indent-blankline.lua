require("indent_blankline").setup({})
vim.cmd[[IndentBlanklineDisable!]]

vim.keymap.set("n", "yog", ":IndentBlanklineToggle<CR>")
