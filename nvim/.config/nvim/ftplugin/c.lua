local M = {}
local utils = require('mrv.utils')

vim.b.cell_delimeter = '///'

-- Automatically write before make (:h make)
vim.opt_local.autowrite = true

-- Do not re-indent after entering a colon (:) (https://stackoverflow.com/q/19320747/1706778)
vim.opt_local.cinkeys:remove(':')

---------------------------------------------------------------------------------
--- Debug utilities
---------------------------------------------------------------------------------

local print_fun = 'printf'

-- Insert print var statement, go to next `%`, and go to insert mode
vim.keymap.set('n', '<Leader>pr', function()
  utils.insert_string(print_fun .. [[(\"%s = %%\\n\", %s); // DEBUG]], 'o')
  vim.fn.search("%", "W")
  vim.api.nvim_feedkeys('a', 'n', false)
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

-- Send text as if it were typed
vim.g.tomux_use_clipboard = 0

-- Build profiles: each action is { key, cmd }. The key is the <Leader>-mapping
-- that triggers the command.
local profile = 'pio'
local profiles = {
  make = {
    build = { '<Leader>tm', 'make' },
    run   = { '<Leader>e',  'make && ./build/apps/program' },
    test  = { '<Leader>tt', 'make && bash peak-mem-usage.sh' },
    clean = { '<Leader>tc', 'make clean' },
  },
  pio = {
    build        = { '<Leader>tr', 'pio run' },
    upload       = { '<Leader>tu', 'pio run -t nobuild -t upload' },
    monitor      = { '<Leader>tm', 'pio device monitor' },
    build_upload = { '<Leader>e',  'pio run -t upload' },
    all          = { '<Leader>tt', 'pio run -t upload -t monitor' },
    clean        = { '<Leader>tc', 'pio run -t clean' },
    erase        = { '<Leader>tE', 'pio run -t erase' },
    size         = { '<Leader>ts', 'pio run -t size' },
  },
  cmake = {
    build = { '<Leader>tm', 'cmake --build build' },
    run   = { '<Leader>e',  'cmake --build build && ./build/apps/program' },
    test  = { '<Leader>tt', 'cmake --build build && ctest --test-dir build' },
    clean = { '<Leader>tc', 'cmake --build build --target clean' },
  },
}
local active = profiles[profile]

-- Send a command to the tmux pane after saving the buffer
local function send(cmd)
  vim.cmd.update()
  vim.cmd(string.format([[TomuxSend("%s\n")]], cmd))
end

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

-- Register a keymap for each action in the active profile
local seen = {}
for name, action in pairs(active) do
  local key, cmd = action[1], action[2]
  if seen[key] then
    vim.notify(
      ("build profile: key %s used by both %s and %s"):format(key, seen[key], name),
      vim.log.levels.WARN
    )
  end
  seen[key] = name
  vim.keymap.set('n', key, function() send(cmd) end, { buffer = true })
end

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Clear pane
vim.keymap.set('n', '<Leader>cl', function()
  vim.cmd [[TomuxSend("clr\n")]]
end, { buffer = true })

return M
