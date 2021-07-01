local M = {}

M.remap = function(mode, lhs, rhs, opts)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

return M

