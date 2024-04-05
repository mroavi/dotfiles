local vim = vim
local utils = require('mrv.utils')

local M = {}

-- Define cell_delimeter
vim.b.cell_delimeter = '/// '

-- Use 4 spaces for indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

---------------------------------------------------------------------------------
--- Debug utilities
---------------------------------------------------------------------------------

local print_fun = 'Console.WriteLine'

-- Insert print var statement
vim.keymap.set('n', '<Leader>pr', function()
  utils.insert_string(print_fun .. [[($\"%s = {%s}\"); // DEBUG]], 'o')
end, { buffer = true })

-- Insert print list statement
vim.keymap.set('n', '<Leader>pl', function()
  utils.insert_string([[%s.ForEach(]] .. print_fun .. [[);]], 'o')
end, { buffer = true })

-- Insert print array statement
vim.keymap.set('n', '<Leader>pa', function()
  utils.insert_string([[Array.ForEach(%s, ]] .. print_fun .. [[);]], 'o')
end, { buffer = true })

--------------------------------------------------------------------------------
--- vim-commentary
--------------------------------------------------------------------------------

-- No space between comment characters and code
vim.b.commentary_format = '//%s'

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
    vim.cmd[[TomuxCommand("split-window -h -d -c " . getcwd())]]
end, { buffer = true })

-- Split the current window horizontally, adding a new pane to the bottom
-- The new pane starts in Vim's current working directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd[[TomuxCommand("split-window -v -d -l 20% -c "  . getcwd())]]
end, { buffer = true })

-- Build
vim.keymap.set('n', '<Leader>tb', function()
  vim.cmd.write()
  vim.cmd[[TomuxSend("dotnet build\n")]]
end, { buffer = true })

-- Clean
vim.keymap.set('n', '<Leader>tc', function()
  vim.cmd.write()
  vim.cmd[[TomuxSend("dotnet clean\n")]]
end, { buffer = true })

-- Run
vim.keymap.set('n', '<Leader>tr', function()
  vim.cmd.write()
  vim.cmd[[TomuxSend("dotnet run\n")]]
end, { buffer = true })

-- Watch
vim.keymap.set('n', '<Leader>tw', function()
  vim.cmd.write()
  vim.cmd[[TomuxSend("dotnet watch\n")]]
end, { buffer = true })

-- Execute buffer
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd[[TomuxSend("dotnet run\n")]]
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Run tests
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd[[TomuxSend("dotnet test\n")]]
end, { buffer = true })

-- Clear pane
vim.keymap.set('n', '<Leader>cl', function()
  vim.cmd [[TomuxSend("clr\n")]]
end, { buffer = true })

return M
