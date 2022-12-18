-- Add commands similar to those available through the Git plugin in Oh My ZSH
vim.api.nvim_command([[
command! -complete=file -nargs=* Gdiff Git diff <args>
command! -complete=file -nargs=* Gdstaged Git diff --staged <args>
]])

vim.keymap.set("n", "<Leader>gs", "<Cmd>Gedit :<CR>") -- https://github.com/tpope/vim-fugitive/issues/1296
--vim.keymap.set("n", "<C-g>", "<Cmd>keepalt Gedit :<CR>") -- keep the alternate file

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
