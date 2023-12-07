local vim = vim
local utils = require('mrv.utils')

-- Define cell_delimeter
vim.b.cell_delimeter = '-- @block'

--------------------------------------------------------------------------------
--- vim-commentary
--------------------------------------------------------------------------------

-- No space between comment characters and code
vim.b.commentary_format = '--%s'

---------------------------------------------------------------------------------
-- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Start REPL cmd
--vim.b.start_repl_cmd = 'sudo mariadb -u root -p'
vim.b.start_repl_cmd = 'mariadb -u mroavi'

local M = {}

-- Start mariadb command line in a RIGHT split with active buffer as CWD
function M.open_right_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd[[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_repl_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

---- Execute buffer
--function M.execute_buffer()
--  vim.cmd.write()
--  vim.cmd[[TomuxSend("exec(open(\"" . expand('%:p') . "\").read())\n")]]
--end
--vim.keymap.set('n', '<Leader>e', function() M.execute_buffer() end, { buffer = true })

-- Clear command line
function M.clear()
  vim.cmd[[TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-l")]]
end
vim.keymap.set('n', '<Leader>cl', function() M.clear() end, { buffer = true })

-- Kill pane
function M.kill_pane()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

return M
