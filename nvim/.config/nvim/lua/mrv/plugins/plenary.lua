local M = {}

M.reload = function(verbose)
  require("plenary.reload").reload_module("mrv")
  require("mrv")
  if verbose == true then
    print("Configuration reloaded")
  end
end

local utils = require('mrv.utils')
utils.remap("n", "<Leader>re", "<Cmd>lua require('mrv.plugins.plenary').reload(true)<CR>")

return M

