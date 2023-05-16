local vim = vim
local utils = require('mrv.utils')

M = {}

---------------------------------------------------------------------------------
-- Debug utilities
---------------------------------------------------------------------------------

-- Write and source ( https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script )
vim.keymap.set('n', '<Leader>so', [[<Cmd>write <Bar> luafile %<Cr>]], { buffer = true })

-- Insert print statement
local print_fun = 'print'
--local print_fun = 'vim.print'
vim.keymap.set('n', '<Leader>pr', function() utils.insert_string(print_fun .. [[('%s = ', %s)]], 'o') end, { buffer = true })

-- Insert dump statement
vim.keymap.set('n', '<Leader>du', function() utils.insert_string("dump" .. [[('%s = ', %s)]], 'o') end, { buffer = true })

---------------------------------------------------------------------------------
-- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Split the current pane vertically
function M.open_right_of()
  vim.cmd[[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Kill pane
function M.kill_pane()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

-- Run tests
function M.run_tests()
  vim.cmd.write()
  vim.cmd[[TomuxSend("clr\nbusted\n")]]
end
vim.keymap.set('n', '<Leader>tt', function() M.run_tests() end, { buffer = true })

-- Execute buffer
function M.execute()
  vim.cmd.write()
  vim.cmd[[TomuxSend("lua " . expand('%:p') . "\n")]]
end
vim.keymap.set('n', '<Leader>e', function() M.execute() end, { buffer = true })

-- Clear pane
vim.keymap.set('n', '<Leader>cl', function() vim.cmd[[TomuxSend("clr\n")]] end, { buffer = true })

return M
