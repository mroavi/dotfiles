-- Automatically fitting a quickfix window height
-- https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
vim.api.nvim_command([[
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
au FileType qf call AdjustWindowHeight(3, 10)
]])
