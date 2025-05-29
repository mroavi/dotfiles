local vim = vim
local utils = require('mrv.utils')

---------------------------------------------------------------------------------
--- Debug utilities
---------------------------------------------------------------------------------

vim.keymap.set('n', '<Leader>pr', function()
  utils.insert_string([[console.log(\"'%s': \" + %s); // DEBUG]], 'o')
end, { buffer = true })

vim.keymap.set('n', '<Leader>pt', function()
  utils.insert_string([[console.table(%s); // DEBUG]], 'o')
end, { buffer = true })

-------------------------------------------------------------------------------
-- conform
-------------------------------------------------------------------------------

-- Install `prettier` with Mason

-- Enable formatting using the gq operator
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

