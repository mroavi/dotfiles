local M = {}

M.remap = function(mode, lhs, rhs, opts)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

M.reload = function()
  print("Configuration reloaded")
  require("plenary.reload").reload_module("mrv")
end

M.remap("n", "<Leader>re", "<Cmd>lua require('mrv.utils').reload('mrv')<CR>")

return M

