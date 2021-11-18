-- Add commands similar to those available through the Git plugin in Oh My ZSH
vim.api.nvim_command([[
command! -complete=file -nargs=* Gdiff Git diff <args>
command! -complete=file -nargs=* Gdstaged Git diff --staged <args>
]])

local utils = require('mrv.utils')
utils.remap("n", "<Leader>gs", "<Cmd>:Gedit :<CR>")
utils.remap("n", "<Leader>i", "<Cmd>:Gedit :<CR>")
utils.remap("n", "<Leader>gw",  "<Cmd>:Gwrite<CR>")
utils.remap("n", "<Leader>gc",  "<Cmd>:Git commit -v<CR>")
utils.remap("n", "<Leader>gp",  "<Cmd>:Git push<CR>")
utils.remap("n", "<Leader>gl",  "<Cmd>:Git pull<CR>")
-- The LHS of the mappings below are being used elsewhere
--utils.remap("n", "<Leader>gr",  "<Cmd>:Gread<CR>")
--utils.remap("n", "<Leader>gdi", "<Cmd>:Gdiff<CR>")
--utils.remap("n", "<Leader>gds", "<Cmd>:Gdstaged<CR>")

-- Emulates the zsh aliases in nvim's command line
vim.cmd('cnoreabbrev gst  Gedit :')
vim.cmd('cnoreabbrev ga   Gwrite')
vim.cmd('cnoreabbrev gc   Git commit -v')
vim.cmd('cnoreabbrev gp   Git push')
vim.cmd('cnoreabbrev gl   Git pull')
--vim.cmd('cnoreabbrev glg  Git log') -- using GV in favor of this

