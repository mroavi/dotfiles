local vim = vim
local utils = require('mrv.utils')

---------------------------------------------------------------------------------
-- Debug utilities
---------------------------------------------------------------------------------

-- Write and execute ( https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script )
vim.keymap.set('n', '<Leader>e', [[<Cmd>write <Bar> luafile %<Cr>]], { buffer = true })

-- Insert pretty print statement
vim.keymap.set('n', '<Leader>pr', function() utils.insert_string([[vim.pretty_print('%s = ', %s)]], 'o') end, { buffer = true })
