local M = {}

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

-- Send text as if it were typed
vim.g.tomux_use_clipboard = 0

-- Split the current window vertically, adding a new pane to the right
-- The new pane starts in Vim's current working directory
function M.open_right_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd[[TomuxCommand("split-window -h -d -c " . getcwd())]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Split the current window horizontally, adding a new pane to the bottom
-- The new pane starts in Vim's current working directory
function M.open_bottom_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd[[TomuxCommand("split-window -v -d -l 20% -c " . getcwd())]]
end
vim.keymap.set('n', '<Leader>tj', function() M.open_bottom_of() end, { buffer = true })

-- Make
function M.make()
  vim.cmd.write()
  vim.cmd[[TomuxSend("make\n")]]
end
vim.keymap.set('n', '<Leader>tm', function() M.make() end, { buffer = true })

-- Make and execute
function M.execute()
  vim.cmd.write()
  vim.cmd[[TomuxSend("make && ./build/apps/program\n")]] -- WARNING: update the path to the executable
end
vim.keymap.set('n', '<Leader>e', function() M.execute() end, { buffer = true })

-- Clean
function M.clean()
  vim.cmd.write()
  vim.cmd[[TomuxSend("make clean\n")]]
end
vim.keymap.set('n', '<Leader>tc', function() M.clean() end, { buffer = true })

-- Kill pane
function M.kill_pane()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

-- Clear pane
vim.keymap.set('n', '<Leader>cl', function() vim.cmd[[TomuxSend("clr\n")]] end, { buffer = true })

return M
