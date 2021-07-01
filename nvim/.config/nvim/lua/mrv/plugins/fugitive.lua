-- Add commands similar to those available through the Git plugin in Oh My ZSH
vim.api.nvim_command([[
command! -complete=file -nargs=* Gdiff Git diff <args>
command! -complete=file -nargs=* Gdstaged Git diff --staged <args>
]])

local utils = require('mrv.utils')
utils.remap("n", "<Leader>gst", "<CMD>:Ge:<CR>")
utils.remap("n", "<Leader>gw",  "<CMD>:Gwrite<CR>")
utils.remap("n", "<Leader>gc",  "<CMD>:Git commit -v<CR>")
utils.remap("n", "<Leader>gp",  "<CMD>:Git push<CR>")
utils.remap("n", "<Leader>gl",  "<CMD>:Git pull<CR>")
utils.remap("n", "<Leader>glg", "<CMD>:Git log<CR>")
-- The LHS of the mappings below are being used elsewhere
-- utils.remap("n", "<Leader>gr",  "<CMD>:Gread<CR>")
-- utils.remap("n", "<Leader>gdi", "<CMD>:Gdiff<CR>")
-- utils.remap("n", "<Leader>gds", "<CMD>:Gdstaged<CR>")

