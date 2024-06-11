local vim = vim
local utils = require 'mrv.utils'

local M = {}

-- Open PDF preview
vim.keymap.set(
  'n',
  '<Leader>to',
  "<Cmd>AsyncRun -silent xdg-open ./main.pdf<CR>",
  { buffer = true }
)

------------------------------------------------------------------------------
-- vim-tomux
------------------------------------------------------------------------------

-- Start typst cmd
vim.b.start_typst = "typst watch main.typ main.pdf"

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Split the current pane vertically and start 'typst'
function M.open_right_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd[[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_typst . "\n")]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Split the current pane horizontally and start 'typst'
function M.open_down_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd[[TomuxCommand("split-window -v -d -l 10% -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_typst . "\n")]]
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
