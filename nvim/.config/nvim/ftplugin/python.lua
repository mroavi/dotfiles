local vim = vim
local utils = require('mrv.utils')

---------------------------------------------------------------------------------
-- Debug utilities
---------------------------------------------------------------------------------

-- Insert print statement
local print_fun = 'print'
--local print_fun = 'vim.print'
vim.keymap.set('n', '<Leader>pr', function() utils.insert_string(print_fun .. [[('%s = ', %s)]], 'o') end, { buffer = true })

---------------------------------------------------------------------------------
-- vim-tomux
---------------------------------------------------------------------------------

-- Make sure to have 'ipython' and 'tk' installed.
-- 'tk' is needed to use the `%paste` magic function.
-- (Source: https://superuser.com/a/549325/1087113)
-- On Arch, you can install these with the following commands:
--   sudo pacman -S ipython
--   sudo pacman -S tk

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 1

-- IPython's "paste" function
vim.b.tomux_clipboard_paste = "%paste -q"

-- Start REPL cmd
vim.b.start_repl_cmd = 'python -m IPython'

-- Exit REPL cmd
vim.b.quit_repl_cmd = 'exit()'

local M = {}

-- Start interpreter in a RIGHT split with active buffer as CWD
function M.open_right_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd[[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_repl_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Start interpreter in a RIGHT split with active buffer as CWD
function M.open_down_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd[[TomuxCommand("split-window -v -d -l 20% -c " . expand("%:p:h"))]]
  vim.cmd [[TomuxSend(b:start_repl_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tj', function() M.open_down_of() end, { buffer = true })

-- Execute buffer
function M.execute_buffer()
  vim.cmd.write()
  vim.cmd[[TomuxSend("exec(open(\"" . expand('%:p') . "\").read())\n")]]
end
vim.keymap.set('n', '<Leader>e', function() M.execute_buffer() end, { buffer = true })

-- Restart interpreter (send first CTRL-c, and then restart)
function M.restart()
  vim.cmd[[TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")]]
  vim.cmd[[TomuxSend(b:quit_repl_cmd . "\n")]]
  vim.cmd[[sl 50m]]
  vim.cmd[[TomuxSend(b:start_repl_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tr', function() M.restart() end, { buffer = true })

-- Quit interpreter (send first CTRL-c and then quit)
function M.quit()
  vim.cmd[[TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")]]
  vim.cmd[[TomuxSend(b:quit_repl_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tq', function() M.quit() end, { buffer = true })

-- Kill interpreter
function M.kill_pane()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

-- Run tests
function M.run_tests()
  vim.cmd.write()
  vim.cmd[[TomuxSend("!pytest -o markers=task\n")]]
end
vim.keymap.set('n', '<Leader>tt', function() M.run_tests() end, { buffer = true })

-- Clear interpreter
function M.clear()
  vim.cmd[[TomuxSend("print(\"\\n\" * 100)\n")]]
end
vim.keymap.set('n', '<Leader>cl', function() M.clear() end, { buffer = true, silent = true })

return M
