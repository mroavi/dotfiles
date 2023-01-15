local vim = vim
local utils = require('mrv.utils')

---------------------------------------------------------------------------------
-- Debug utilities
---------------------------------------------------------------------------------

vim.keymap.set('n', '<Leader>pr', function() utils.toggle_string([[ |> println]], 'A') end, { buffer = true })
vim.keymap.set('n', '<Leader>bt', function() utils.toggle_string([[@btime ]], 'I') end, { buffer = true })
vim.keymap.set('n', '<Leader>du', function() utils.toggle_string([[ |> dump]], 'A') end, { buffer = true })
--vim.keymap.set('n', '<Leader>sh', function() utils.toggle_string('@sshow ', 'I') end, { buffer = true })
vim.keymap.set('n', '<Leader>sh', function() utils.insert_string([[@show %s]], 'o') end, { buffer = true })
