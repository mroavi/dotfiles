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

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Open a pane to the right, starting in Neovim's current working directory
vim.keymap.set('n', '<Leader>tl', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd([[TomuxCommand("split-window -h -d -c '" . getcwd() . "'")]])
end, { buffer = true })

-- Open a pane below, starting in Neovim's current working directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd([[TomuxCommand("split-window -v -d -l 15% -c '" . getcwd() . "'")]])
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Save, start Vite dev server, and open a new Brave window
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("npm run dev\n")]]
  os.execute("brave --new-window http://localhost:5173 &")
end, { buffer = true })

-- Install
vim.keymap.set('n', '<Leader>ti', function()
  vim.cmd [[TomuxSend("npm install\n")]]
end, { buffer = true })
