local M = {}

-- Global mappings
M.remap = function(mode, lhs, rhs, opts)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

-- Buffer-local mappings
M.remap_buff = function(mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(mode, lhs, rhs, opts or {noremap = true})
end

M.reload = function(verbose)
  require("plenary.reload").reload_module("mrv")
	require("mrv")
	if verbose == true then
		print("Configuration reloaded")
	end
end

return M
