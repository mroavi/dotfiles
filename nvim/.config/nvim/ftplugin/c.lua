local M = {}
local utils = require('mrv.utils')

---------------------------------------------------------------------------------
--- Debug utilities
---------------------------------------------------------------------------------

local print_fun = 'printf'

-- Insert print var statement, go to next `%`, and go to insert mode
vim.keymap.set('n', '<Leader>pr', function()
  utils.insert_string(print_fun .. [[(\"%s = %%\\n\", %s); // DEBUG]], 'o')
  vim.fn.search("%", "W")
  vim.api.nvim_feedkeys('a', 'n', false)
end, { buffer = true })

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

-- Send text as if it were typed
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
  vim.cmd [[TomuxCommand("split-window -v -d -l 20% -c " . getcwd())]]
end, { buffer = true })

-- Make
vim.keymap.set('n', '<Leader>tm', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("make\n")]]
end, { buffer = true })

-- Make and execute
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("make && ./build/apps/program\n")]] -- WARNING: update the path to the executable
end, { buffer = true })

-- Test
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("make && bash peak-mem-usage.sh\n")]] -- WARNING: update command as needed
end, { buffer = true })

-- Clean
vim.keymap.set('n', '<Leader>tc', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("make clean\n")]]
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Clear pane
vim.keymap.set('n', '<Leader>cl', function()
  vim.cmd [[TomuxSend("clr\n")]]
end, { buffer = true })

return M
