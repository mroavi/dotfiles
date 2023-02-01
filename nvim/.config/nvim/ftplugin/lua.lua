local vim = vim
local utils = require('mrv.utils')

M = {}

---------------------------------------------------------------------------------
-- Debug utilities
---------------------------------------------------------------------------------

-- Write and source ( https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script )
vim.keymap.set('n', '<Leader>so', [[<Cmd>write <Bar> luafile %<Cr>]], { buffer = true })

-- Insert pretty print statement
vim.keymap.set('n', '<Leader>pr', function() utils.insert_string([[vim.pretty_print('%s = ', %s)]], 'o') end, { buffer = true })

---------------------------------------------------------------------------------
-- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Start REPL cmd (activate environment found in the current dir or parents)
vim.b.start_repl_cmd = ""

-- Start REPL in a RIGHT split with active buffer as CWD
function M.open_right_of()
  vim.cmd[[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_repl_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Kill REPL
function M.kill_pane()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

-- Run tests
vim.keymap.set('n', '<Leader>tt', function() vim.cmd[[TomuxSend("busted\n")]] end, { buffer = true })

return M
