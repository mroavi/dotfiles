local vim = vim
local utils = require('mrv.utils')

---------------------------------------------------------------------------------
-- Debug utilities
---------------------------------------------------------------------------------

vim.keymap.set('n', '<Leader>pr', function() utils.insert_debug([[vim.pretty_print('%s = ', %s)]]) end)
