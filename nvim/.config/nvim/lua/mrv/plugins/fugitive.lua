-- Add commands similar to those available through the Git plugin in Oh My ZSH
vim.api.nvim_command([[
command! -complete=file -nargs=* Gdiff Git diff <args>
command! -complete=file -nargs=* Gdstaged Git diff --staged <args>
]])

local utils = require('mrv.utils')
utils.remap("n", "<Leader>gs", "<Cmd>:Ge:<CR>")
utils.remap("n", "<Leader>gw",  "<Cmd>:Gwrite<CR>")
utils.remap("n", "<Leader>gc",  "<Cmd>:Git commit -v<CR>")
utils.remap("n", "<Leader>gp",  "<Cmd>:Git push<CR>")
utils.remap("n", "<Leader>gl",  "<Cmd>:Git pull<CR>")
utils.remap("n", "<Leader>glg", "<Cmd>:Git log<CR>")
-- The LHS of the mappings below are being used elsewhere
-- utils.remap("n", "<Leader>gr",  "<Cmd>:Gread<CR>")
-- utils.remap("n", "<Leader>gdi", "<Cmd>:Gdiff<CR>")
-- utils.remap("n", "<Leader>gds", "<Cmd>:Gdstaged<CR>")

