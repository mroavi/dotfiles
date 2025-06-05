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

-- Use :write instead of :update to force BrowserSync to reload and run the JS code
vim.keymap.set("n", "<Leader>w", ":write<CR>", { buffer = true })

-------------------------------------------------------------------------------
-- conform
-------------------------------------------------------------------------------

-- Install `prettier` with Mason

-- Enable formatting using the gq operator
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Split the current window vertically, adding a new pane to the right
-- The new pane starts in Vim's current working directory
vim.keymap.set('n', '<Leader>tl', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd [[TomuxCommand("split-window -h -d -c " . getcwd())]]
end, { buffer = true })

-- Split the current window horizontally, adding a new pane to the bottom
-- The new pane starts in Vim's current working directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd [[TomuxCommand("split-window -v -d -l 20% -c "  . getcwd())]]
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Run (execute)
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("node " . expand('%:p'). "\n")]]
end, { buffer = true })

-- Test
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd [[TomuxSend("node --test\n")]]
end, { buffer = true })
