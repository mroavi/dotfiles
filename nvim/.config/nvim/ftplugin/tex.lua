-- Automatically fitting a quickfix window height
-- https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
vim.api.nvim_command([[
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
au FileType qf call AdjustWindowHeight(3, 10)
]])

-------------------------------------------------------------------------------
-- conform
-------------------------------------------------------------------------------

-- Install `latexindent` with Mason

-- https://stackoverflow.com/a/71455879
-- To fix: `dlopen: libcrypt.so.1: cannot open shared object file` run
--  pac -S libxcrypt-compat

-- Enable formatting using the gq operator
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
