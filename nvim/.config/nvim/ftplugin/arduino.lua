local vim = vim
local utils = require('mrv.utils')

-- No space between comment character and code
vim.b.commentary_format = '//%s'

-- Extend Arduino filetype to use C++ snippets in LuaSnip
require("luasnip").filetype_extend("arduino", {"cpp"})

-------------------------------------------------------------------------------
-- conform
-------------------------------------------------------------------------------

-- Install `clang-format` with Mason

-- Enable formatting using the gq operator
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

---------------------------------------------------------------------------------
--- cmp
---------------------------------------------------------------------------------

---- Disable a given source for this filetype
--local cmp = require('cmp')
--local sources = cmp.get_config().sources
--for i = #sources, 1, -1 do
--  if sources[i].name == 'buffer' then
--    table.remove(sources, i)
--  end
--end
--cmp.setup.buffer({ sources = sources })

-------------------------------------------------------------------------------
-- Debug utilities
-------------------------------------------------------------------------------

-- Insert print statement
local print_fun = 'Serial.println'
vim.keymap.set('n', '<Leader>pr', function() utils.insert_string(print_fun .. [[('%s = ', %s);]], 'o') end, { buffer = true })

-- Insert print var statement
vim.keymap.set('n', '<Leader>pr', function()
  utils.insert_string([[Serial.print(\"'%s': \"); Serial.println(%s); // DEBUG]], 'o')
end, { buffer = true })


-------------------------------------------------------------------------------
-- vim-tomux
-------------------------------------------------------------------------------

-- Source: https://arduino.github.io/arduino-cli/0.33/getting-started/
--
-- arduino-cli one-time setup:
--   arduino-cli config init
--   arduino-cli core update-index
--   arduino-cli core install arduino:avr
--   sudo chmod a+rw /dev/ttyACM0
--   sudo chmod a+rw /dev/ttyACM1
--   sudo chmod a+rw /dev/ttyUSB0
--   sudo chmod a+rw /dev/ttyUSB1
--
-- Other commads:
--   arduino-cli board list
--   arduino-cli core list
--   arduino-cli sketch new serial-hello-world

-- CONFIG ME!!!

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.b.serial_port = '/dev/ttyUSB0'
--vim.b.serial_port = '/dev/ttyUSB1'
--vim.b.serial_port = '/dev/ttyACM0'
--vim.b.serial_port = '/dev/ttyACM1'

--vim.b.serial_baud = '9600'
vim.b.serial_baud = '115200'

vim.b.board = 'arduino:avr:uno'
--vim.b.board = 'arduino:avr:mega'
--vim.b.board = 'esp32:esp32:esp32'
--vim.b.board = 'arduino:renesas_uno:unor4wifi'

local M = {}

-- Start interpreter in a RIGHT split with active buffer as CWD
function M.open_right_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd [[TomuxCommand("split-window -h -d -c " . expand("%:p:h"))]]
end
vim.keymap.set('n', '<Leader>tl', function() M.open_right_of() end, { buffer = true })

-- Start interpreter in a BOTTOM split with active buffer as CWD
function M.open_down_of()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd [[TomuxCommand("split-window -v -d -l 20% -c " . expand("%:p:h"))]]
end
vim.keymap.set('n', '<Leader>tj', function() M.open_down_of() end, { buffer = true })

-- Kill pane
function M.kill_pane()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end
vim.keymap.set('n', '<Leader>tk', function() M.kill_pane() end, { buffer = true })

-- Compile
function M.compile()
  vim.cmd.write()
  vim.cmd [[TomuxSend("arduino-cli compile -b " . b:board . " " . expand('%:p') . "\n")]]
end
vim.keymap.set('n', '<Leader>tc', function() M.compile() end, { buffer = true })

-- Upload
function M.upload()
  vim.cmd.write()
  vim.cmd [[TomuxSend("arduino-cli upload -p " . b:serial_port . " --fqbn " . b:board . " " . expand('%:p') . "\n")]]
end
vim.keymap.set('n', '<Leader>tu', function() M.upload() end, { buffer = true })

-- Start 'screen' and open serial port
function M.start_screen()
  vim.cmd [[TomuxSend("screen " . b:serial_port . " " . b:serial_baud . " " . "\n")]]
end
vim.keymap.set('n', '<Leader>ts', function() M.start_screen() end, { buffer = true })

-- Kill 'screen'
function M.kill_screen()
  vim.cmd [[TomuxSend("Ky")]]
end
vim.keymap.set('n', '<Leader>tK', function() M.kill_screen() end, { buffer = true })

-- Compile and upload (p stands for program)
function M.compile_and_upload()
  M.compile()
  M.upload()
end
vim.keymap.set('n', '<Leader>tp', function() M.compile_and_upload() end, { buffer = true })

-- Kill 'screen', Compile, upload and open serial port
function M.kill_compile_and_upload()
  M.kill_screen()
  vim.cmd("sleep 100m")
  M.compile()
  vim.cmd("sleep 100m")
  M.upload()
  M.start_screen()
end
vim.keymap.set('n', '<Leader>tt', function() M.kill_compile_and_upload() end, { buffer = true })

return M
