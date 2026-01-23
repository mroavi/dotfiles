local vim = vim

-- No space between comment character and code
vim.b.commentary_format = '//%s'

-- Include `!` as part of a vim 'word'
vim.opt_local.iskeyword:append('!')

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Send the code directly (not using the clipboard)
vim.g.tomux_use_clipboard = 0

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

-- Compile and run
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("cargo run\n")]]
end, { buffer = true })

-- Build project
vim.keymap.set('n', '<Leader>tb', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("cargo build\n")]]
end, { buffer = true })

-- Clean project
vim.keymap.set('n', '<Leader>tc', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("cargo clean\n")]]
end, { buffer = true })

-- Open a pane to the right, starting in the ACTIVE BUFFER's directory
vim.keymap.set('n', '<Leader>tl', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd([[TomuxCommand("split-window -h -d -c " . shellescape(expand("%:p:h"))) ]])
end, { buffer = true })

-- Open a pane below, starting in the ACTIVE BUFFER's directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd([[TomuxCommand("split-window -v -d -l 20% -c " . shellescape(expand("%:p:h"))) ]])
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Format file
vim.keymap.set('n', '<Leader>tf', function()
  vim.cmd [[TomuxSend("rustfmt " . expand("%:p") . "\n")]]
end, { buffer = true })

-- Clear REPL
vim.keymap.set('n', '<Leader>cl', function()
  vim.cmd [[TomuxSend("clr\n")]]
end, { buffer = true })

-- Run tests
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd [[TomuxSend("cargo test\n")]]
end, { buffer = true })
