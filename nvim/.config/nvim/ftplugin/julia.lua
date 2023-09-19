local vim = vim
local utils = require('mrv.utils')

-- Define cell_delimeter
vim.b.cell_delimeter = '##'

-- Inserts different kinds of headers
vim.cmd [[
nnoremap <buffer><Leader>h1 m`<S-o># <Esc>78a=<Esc>yyjp``
nnoremap <buffer><Leader>h2 m`<S-o># <Esc>78a-<Esc>yyjp``
nnoremap <buffer><Leader>h3 m`0dw :center 80<CR>hhv0r-A<Space><Esc>40A-<Esc>d78<Bar>I#<Space><Esc>``
]]

--------------------------------------------------------------------------------
--- Debug utilities
--------------------------------------------------------------------------------

vim.keymap.set('n', '<Leader>pr', function() utils.toggle_string([[ |> println]], 'A') end, { buffer = true })
vim.keymap.set('n', '<Leader>bt', function() utils.toggle_string([[@btime ]], 'I') end, { buffer = true })
vim.keymap.set('n', '<Leader>du', function() utils.toggle_string([[ |> dump]], 'A') end, { buffer = true })
--vim.keymap.set('n', '<Leader>sh', function() utils.toggle_string('@sshow ', 'I') end, { buffer = true })
vim.keymap.set('n', '<Leader>sh', function() utils.insert_string([[@show %s]], 'o') end, { buffer = true })
