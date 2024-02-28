local vim = vim
local utils = require 'mrv.utils'

local M = {}

-- Handy heading mappings
vim.keymap.set( "n", "<Leader>h1", function() utils.insert_heading("=") end, { buffer = true })
vim.keymap.set( "n", "<Leader>h2", function() utils.insert_heading("-") end, { buffer = true })

-- Fold inner tag
vim.keymap.set('n', "zfit", [[:norm vitojzf<Cr>]], { buffer = true, silent = true })

------------------------------------------------------------------------------
-- vim-tomux
------------------------------------------------------------------------------

-- Dependency installation:
-- npm install -g browser-sync

-- Start browser-sync cmd
vim.b.start_browser_sync_cmd = "browser-sync start --server --files '*.html, *.css, *.js' --no-notify"

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Split the current pane vertically and start 'browser-sync'
function M.open_right_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd[[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_browser_sync_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Split the current pane horizontally and start 'browser-sync'
function M.open_down_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd[[TomuxCommand("split-window -v -d -l 10% -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_browser_sync_cmd . "\n")]]
end
vim.keymap.set('n', '<Leader>tj', function() M.open_down_of() end, { buffer = true })

-- Kill pane
function M.kill_pane()
  vim.cmd[[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

-- Clear pane
vim.keymap.set('n', '<Leader>cl', function() vim.cmd[[TomuxSend("clr\n")]] end, { buffer = true })

return M
