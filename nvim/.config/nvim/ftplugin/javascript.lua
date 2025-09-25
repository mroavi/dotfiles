local vim = vim
local utils = require('mrv.utils')

-- No space between comment character and code
vim.b.commentary_format = '//%s'

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

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

---- Start interpreter cmd
--vim.b.start_interpreter_cmd = 'node'

-- Open a pane to the right, starting in Neovim's current working directory
vim.keymap.set('n', '<Leader>tl', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd([[TomuxCommand("split-window -h -d -c '" . getcwd() . "'")]])
  --vim.cmd([[TomuxSend(b:start_interpreter_cmd . "\n")]])
end, { buffer = true })

-- Open a pane below, starting in Neovim's current working directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd([[TomuxCommand("split-window -v -d -l 20% -c '" . getcwd() . "'")]])
  --vim.cmd([[TomuxSend(b:start_interpreter_cmd . "\n")]])
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Run (execute)
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("node " . expand('%:.'). "\n")]]
  --vim.cmd [[TomuxSend(".load " . expand('%:.'). "\n")]]
end, { buffer = true })

-- Test
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd [[TomuxSend("node --test\n")]]
end, { buffer = true })

-- Clear command line
function M.clear()
  vim.cmd[[TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-l")]]
end
vim.keymap.set('n', '<C-l>', function() M.clear() end, { buffer = true })
