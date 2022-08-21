-- Add commands similar to those available through the Git plugin in Oh My ZSH
vim.api.nvim_command([[
command! -complete=file -nargs=* Gdiff Git diff <args>
command! -complete=file -nargs=* Gdstaged Git diff --staged <args>
]])

vim.keymap.set("n", "<Leader>g", "<Cmd>Gedit :<CR>") -- https://github.com/tpope/vim-fugitive/issues/1296

---- Disabled in favor of the command line abbreviations below
--vim.keymap.set("n", "<Leader>gw",  "<Cmd>:Gwrite<CR>")
--vim.keymap.set("n", "<Leader>gc",  "<Cmd>:Git commit -v<CR>")
--vim.keymap.set("n", "<Leader>gp",  "<Cmd>:Git push<CR>")
--vim.keymap.set("n", "<Leader>gl",  "<Cmd>:Git pull<CR>")
---- The LHS of the mappings below are being used elsewhere
--vim.keymap.set("n", "<Leader>gr",  "<Cmd>:Gread<CR>")
--vim.keymap.set("n", "<Leader>gdi", "<Cmd>:Gdiff<CR>")
--vim.keymap.set("n", "<Leader>gds", "<Cmd>:Gdstaged<CR>")

-- Emulates the zsh aliases in nvim's command line
vim.cmd('cnoreabbrev g    Git')
vim.cmd('cnoreabbrev git  Git')
vim.cmd('cnoreabbrev gst  Gedit :')
vim.cmd('cnoreabbrev gd   Gdiffsplit') -- Gdiff is broken
vim.cmd('cnoreabbrev ga   Gwrite')
vim.cmd('cnoreabbrev gc   Git commit -v')
vim.cmd('cnoreabbrev gca  Git commit -v --amend')
vim.cmd('cnoreabbrev gp   Git push')
vim.cmd('cnoreabbrev gl   Git pull')
--vim.cmd('cnoreabbrev glg  Git log') -- using GV in favor of this
