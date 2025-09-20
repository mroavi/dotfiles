local M = {}

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

-- Send text as if it were typed
vim.g.tomux_use_clipboard = 0

-- Open a pane to the right, starting in Neovim's current working directory
vim.keymap.set('n', '<Leader>tl', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd([[TomuxCommand("split-window -h -d -c '" . getcwd() . "'")]])
end, { buffer = true })

-- Open a pane below, starting in Neovim's current working directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd([[TomuxCommand("split-window -v -d -l 20% -c '" . getcwd() . "'")]])
end, { buffer = true })

-- Execute
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("./run\n")]] -- WARNING: update the path to the executable
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
