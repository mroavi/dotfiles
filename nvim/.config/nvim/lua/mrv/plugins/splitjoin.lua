local options = {}
require('splitjoin').setup(options)

vim.keymap.set("n", "gS", function() require'splitjoin'.split() end)
vim.keymap.set("n", "gJ", function() require'splitjoin'.join() end)
