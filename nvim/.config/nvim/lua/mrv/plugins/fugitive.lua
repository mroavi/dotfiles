-- Add commands similar to those available through the Git plugin in Oh My ZSH
vim.cmd("command! -complete=file -nargs=* Gdiff Git diff <args>")
vim.cmd("command! -complete=file -nargs=* Gdstaged Git diff --staged <args>")
vim.cmd("nnoremap <Leader>gst :Ge:<CR>")
vim.cmd("nnoremap <Leader>gw  :Gwrite<CR>")
vim.cmd("nnoremap <Leader>gc  :Git commit -v<CR>")
vim.cmd("nnoremap <Leader>gp  :Git push<CR>")
vim.cmd("nnoremap <Leader>gl  :Git pull<CR>")
vim.cmd("nnoremap <Leader>glg :Git log<CR>")
-- The LHS of the mappings below are being used elsewhere
--vim.cmd("nnoremap <Leader>gr  :Gread<CR>")
--vim.cmd("nnoremap <Leader>gdi :Gdiff<CR>")
--vim.cmd("nnoremap <Leader>gds :Gdstaged<CR>")

