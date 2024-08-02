local vim = vim

local M = {}

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

-- Open PDF preview
vim.keymap.set(
  'n',
  '<Leader>to',
  "<Cmd>AsyncRun -silent xdg-open ./main.pdf<CR>",
  { buffer = true }
)

-- General mappings for navigating wrapped lines
vim.keymap.set('', 'k', 'gk', { silent = true, noremap = true, buffer = true })
vim.keymap.set('', 'j', 'gj', { silent = true, noremap = true, buffer = true })

vim.keymap.set('', '0', 'g0', { silent = true, noremap = true, buffer = true })
vim.keymap.set('', '$', 'g$', { silent = true, noremap = true, buffer = true })

vim.keymap.set('n', 'V', 'g0vg$', { noremap = true, buffer = true })
vim.keymap.set('n', 'D', 'dg$', { noremap = true, buffer = true })
vim.keymap.set('n', 'dd', 'g0vg$d', { noremap = false, buffer = true })
vim.keymap.set('n', 'Y', 'yg$', { noremap = true, buffer = true })
vim.keymap.set('n', 'yy', 'g0vg$y', { noremap = false, buffer = true })
vim.keymap.set('n', 'o', 'g$a<Cr><Cr><Up>', { noremap = false, buffer = true })
vim.keymap.set('n', 'O', 'gkg$a<Cr><Cr><Up>', { noremap = false, buffer = true })
vim.keymap.set('n', 'A', 'g$a', { noremap = false, buffer = true })
vim.keymap.set('n', 'I', 'g0i', { noremap = false, buffer = true })

------ Disable automatic text formatting
--vim.opt_local.formatoptions:remove("t")
--vim.opt_local.formatoptions:remove("c")

---- Set the column to wrap text at, e.g., 80
--vim.opt_local.columns = 80

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
  vim.cmd[[AsyncRun -silent xdg-open ./main.pdf]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Split the current pane horizontally and start 'typst'
function M.open_down_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd[[TomuxCommand("split-window -v -d -l 10% -c " . expand("%:p:h"))]]
  vim.cmd[[TomuxSend(b:start_typst . "\n")]]
  vim.cmd[[AsyncRun -silent xdg-open ./main.pdf]]
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
